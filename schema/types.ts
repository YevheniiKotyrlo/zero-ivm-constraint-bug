/* eslint-disable @typescript-eslint/no-restricted-types -- Type-level metaprogramming: `never` is semantically correct in conditional types (T extends X ? Y : never), generic defaults (R = never), and type-level checks ([T] extends [never]). */
import type { PullRow } from '@rocicorp/zero';

import type { Schema } from './schema';

/**
 * Prettify a type by expanding intersections into a single object type.
 */
type Prettify<T> = { [K in keyof T]: T[K] };

/**
 * Force TypeScript to distribute union types for better intellisense.
 */
type PrettifyUnion<T> = T extends T ? T : never;

type ExtractColumnType<TColumn> = TColumn extends { customType: infer CT }
  ? CT
  : TColumn extends { type: 'string' }
    ? string
    : TColumn extends { type: 'number' }
      ? number
      : TColumn extends { type: 'boolean' }
        ? boolean
        : TColumn extends { type: 'json' }
          ? unknown
          : never;

/**
 * Extract the TypeScript type for a specific field in a Zero table.
 * Used by validators to derive enum union types from the schema.
 */
type ZeroFieldType<
  TTable extends keyof Schema['tables'],
  TField extends keyof Schema['tables'][TTable]['columns'],
> = ExtractColumnType<Schema['tables'][TTable]['columns'][TField]>;

type TableName = keyof Schema['tables'];
type RelTableName = keyof Schema['relationships'];
type RelName<T extends TableName> = T extends RelTableName ? string & keyof Schema['relationships'][T] : never;
type Row<T extends TableName> = Prettify<PullRow<T>>;

type First<T> = T extends readonly [infer F, ...unknown[]] ? F : never;
type Dest<T extends TableName, R extends RelName<T>> = T extends RelTableName
  ? First<Schema['relationships'][T][R]> extends {
      destSchema: infer D extends TableName;
    }
    ? D
    : never
  : never;
type Many<T extends TableName, R extends RelName<T>> = T extends RelTableName
  ? First<Schema['relationships'][T][R]> extends {
      cardinality: 'many';
    }
    ? true
    : false
  : false;

// AsOne marker - use { relation: { __one: nestedSpec } } to override many→one
interface AsOneMarker<S> {
  readonly __one: S;
}
type Nested<T extends TableName> = {
  [K in RelName<T>]?: AsOneMarker<Spec<Dest<T, K>> | undefined> | Spec<Dest<T, K>>;
};
type Spec<T extends TableName> = Nested<T> | RelName<T>;

type StrRels<T extends TableName, S> = S extends RelName<T> ? S : never;
type ObjRels<T extends TableName, S> = S extends Nested<T> ? S : never;

/**
 * IMPORTANT: All related data is typed as potentially undefined.
 *
 * This is because during Zero's sync phase (status='unknown'), related data
 * may not be loaded yet, even though Zero's official types say arrays are
 * always present. TypeScript cannot enforce runtime status checks, so we
 * err on the side of safety.
 *
 * @see apps/frontend/src/__tests__/zero-types-investigation.ts for details
 */
type ResolveStr<T extends TableName, R extends RelName<T>> = {
  readonly [K in R]: Many<T, K> extends true
    ? readonly Prettify<Res<Dest<T, K>, never>>[] | undefined
    : Prettify<Res<Dest<T, K>, never>> | undefined;
};

type ResolveNested<T extends TableName, R extends RelName<T>, S> =
  S extends AsOneMarker<infer I>
    ? Prettify<Res<Dest<T, R>, I>> | undefined
    : Many<T, R> extends true
      ? readonly Prettify<Res<Dest<T, R>, S>>[] | undefined
      : Prettify<Res<Dest<T, R>, S>> | undefined;

type ResolveObj<T extends TableName, N extends Nested<T>> = {
  readonly [K in RelName<T> & keyof N]: ResolveNested<T, K, N[K]>;
};

type Build<T extends TableName, S> = ([ObjRels<T, S>] extends [never] ? unknown : ResolveObj<T, ObjRels<T, S>>) &
  ([StrRels<T, S>] extends [never] ? unknown : ResolveStr<T, StrRels<T, S>>);

type Res<T extends TableName, S> = [S] extends [never]
  ? Row<T>
  : [S] extends [undefined]
    ? Row<T>
    : Prettify<Build<T, S> & Row<T>>;

/**
 * Universal Zero row type helper. Infers cardinality from schema.
 *
 * **Just table:**
 * ```typescript
 * type User = ZeroTableRow<'user'>;
 * ```
 *
 * **Table + relations (auto one/many from schema):**
 * ```typescript
 * type Order = ZeroTableRow<'fillOrder', 'patient' | 'shipments'>;
 * ```
 *
 * **Nested relations:**
 * ```typescript
 * type Order = ZeroTableRow<'fillOrder', { shipments: 'shipmentLabels' }>;
 * ```
 *
 * **Override many→one (when using .one() on nested query):**
 * Use `{ __one: nestedSpec }` to convert a "many" relationship to single | undefined.
 * ```typescript
 * // Get first guardian only: .related('patient', q => q.related('patientGuardians', g => g.one()))
 * type Order = ZeroTableRow<'fillOrder', { patient: { patientGuardians: { __one: undefined } } }>;
 *
 * // With further nesting: .related('shipments', q => q.one().related('shipmentLabels'))
 * type Order = ZeroTableRow<'fillOrder', { shipments: { __one: 'shipmentLabels' } }>;
 * ```
 */
type ZeroTableRow<T extends TableName, R = never> = [R] extends [never] ? Row<T> : Prettify<Res<T, R>>;

export type { Prettify, PrettifyUnion, ZeroFieldType, ZeroTableRow };
