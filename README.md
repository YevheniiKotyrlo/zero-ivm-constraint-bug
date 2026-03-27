# Zero IVM: `.limit(0).related()` crashes during poke processing

[![Reproduce Bug](https://github.com/YevheniiKotyrlo/zero-ivm-constraint-bug/actions/workflows/reproduce.yml/badge.svg)](https://github.com/YevheniiKotyrlo/zero-ivm-constraint-bug/actions/workflows/reproduce.yml)

CI runs the reproduction automatically — the test fails (red) while the bug exists.

## Versions

`@rocicorp/zero` 1.1.0 (client), `rocicorp/zero:latest` (zero-cache Docker image).
Also observed the same assertion error (different trigger) on 0.26.1 and 1.0.0.

## Bug

A query with `.limit(0)` combined with `.related()` crashes during initial sync with:

```
Error: Constraint should match partition key
    at assert
    at #initialFetch (take.ts)
    at Take.fetch
    at #pushChildChange (join.ts)
    at #pushChild
    at MeasurePushOperator.push
```

The crash is deterministic — same queries + same data = crash every time, including from a clean browser with no prior state.

## Minimal trigger

Two queries are sufficient. Standard React `useQuery`, no custom wrappers.

The actual code in [`app/src/App.tsx`](app/src/App.tsx):

```tsx
// Query 1 — crashes when combined with Query 2.
// With .limit(1) instead of .limit(0), no crash occurs.
useQuery(queries.patient.assignmentList({limit: 0}));

// Query 2 — loads a row that has a non-null FK to the same related table.
useQuery(queries.fillOrder.byIdWithProviderCompany({id: ORDER_ID}));
```

`patient.assignmentList({limit: 0})` resolves to:
```
z.query.patient.orderBy('lastName', 'asc').limit(0).related('providerCompany')
```

`fillOrder.byIdWithProviderCompany({id})` resolves to:
```
z.query.fillOrder.where('id', '=', id).related('providerCompany').one()
```

### What we observed

- `.limit(0)` crashes. `.limit(1)` does not. No other difference.
- Query 1 alone does not crash — Query 2 must also be present.
- Both queries join to the same related table (`providerCompany` → `accounts_company`).
- The related table's DB name (`accounts_company`) sorts alphabetically before the parent table's DB name (`prescriptions_patient`). We have not tested whether this ordering is relevant, but note it in case it helps.

## Reproduce

Prerequisites: Docker (Compose V2), Node.js 22+.

```bash
git clone <this-repo>
cd zero-ivm-constraint-bug

# 1. Install dependencies
npm install

# 2. Start infrastructure and deploy schema
npm run setup

# 3. Start the dev server
npm run dev
```

Open http://localhost:5199 and check the browser console. Within seconds:

```
Constraint should match partition key
PokeHandler clearing due to unexpected poke error
Run loop paused in error state
```

To verify the workaround, change `limit: 0` to `limit: 1` in [`app/src/App.tsx`](app/src/App.tsx) and reload — the error disappears.

### Automated (Playwright, optional)

After steps 1-2 above:

```bash
npx playwright install chromium
npm run dev &
sleep 5
npm test
```

The test asserts zero errors — it **fails** while the bug exists:
```
Result: CRASH (3 errors)
  ✗ .limit(0).related() should not crash during sync
    Expected: 0
    Received: 3
```

## Workaround

```diff
- queries.patient.assignmentList({limit: 0})
+ queries.patient.assignmentList({limit: 1})
```

## Repo structure

```
app/        React app — 2 useQuery calls that trigger the crash
schema/     Zero schema + query definitions
api/        Hono server — required by zero-cache for query resolution (ZERO_QUERY_URL)
docker/     PostgreSQL schema + seed data (3 rows: 1 company, 1 patient, 1 order)
scripts/    Deploys Zero schema permissions to PostgreSQL
e2e/        Playwright test (optional)
```

---

## My analysis

I traced the crash through the client source in `node_modules/@rocicorp/zero/out/`, so I may be off on specifics.

`applyDiffs` in `ivm-branch.ts` processes table diffs in alphabetical key order (`e/{tableName}/...`). `e/accounts_company/...` sorts before `e/prescriptions_patient/...`, so `accounts_company` data hits the IVM pipeline first.

What I think happens:

1. `accounts_company` data pushes into the `Join` child input in Query 1's pipeline
2. `Join.#pushChildChange` backward-fetches the parent: `this.#parent.fetch({ constraint: { providerCompanyId: childRow.id } })`
3. The parent `Take` (from `.limit(0)`) has `partitionKey = undefined`
4. `Take.fetch` enters the `!this.#partitionKey` branch → `#initialFetch`
5. `#initialFetch` asserts `constraintMatchesPartitionKey({ providerCompanyId: ... }, undefined)` → `false` → crash

The assertion looks too strict for `limit: 0` — the `Take` returns zero rows regardless of the constraint, so the mismatch shouldn't matter.

Possible fixes:

1. Skip `Take` creation entirely for `limit: 0` — no rows returned, no pipeline needed
2. Guard `#initialFetch` — return before the assertion when `limit === 0`
3. Relax the assertion when `partitionKey === undefined`
