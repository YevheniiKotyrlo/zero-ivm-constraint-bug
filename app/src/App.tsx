import {useQuery} from '@rocicorp/zero/react';
import {queries} from './schema';

const ORDER_ID = 'cccccccc-0000-0000-0000-000000000001';

export function App() {
  // Query 1 — crashes when combined with Query 2.
  // With .limit(1) instead of .limit(0), no crash occurs.
  const [_searchResults] = useQuery(
    queries.patient.assignmentList({limit: 0}),
  );

  // Query 2 — loads a row with a non-null FK to the same related table.
  const [order] = useQuery(
    queries.fillOrder.byIdWithProviderCompany({id: ORDER_ID}),
  );

  const companyName = (order as any)?.providerCompany?.name ?? '(loading)';

  return (
    <div id="app">
      <h1>Zero IVM: limit(0) + .related() crash</h1>
      <p id="status">{order != null ? 'Synced' : 'Loading...'}</p>
      <p>Company: {companyName}</p>
      <p>Check console for: "Constraint should match partition key"</p>
    </div>
  );
}
