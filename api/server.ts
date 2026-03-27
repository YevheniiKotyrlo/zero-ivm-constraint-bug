import {serve} from '@hono/node-server';
import {Hono} from 'hono';
import {cors} from 'hono/cors';
import {mustGetQuery} from '@rocicorp/zero';
import {handleQueryRequest} from '@rocicorp/zero/server';
import {schema} from '../schema/schema';
import type {AuthContext} from '../schema/schema';
import {queries} from '../schema/queries';

const app = new Hono();
app.use('*', cors());

app.post('/api/zero/query', async c => {
  const ctx: AuthContext = {sub: 'anon', userId: 'anon', role: null};
  const result = await handleQueryRequest(
    (name, args) => mustGetQuery(queries, name).fn({args, ctx}),
    schema,
    c.req.raw,
  );
  return c.json(result);
});

app.post('/api/zero/mutate', async c => c.json({}));
app.get('/', c => c.text('OK'));

const port = Number(process.env.PORT ?? 3099);
serve({fetch: app.fetch, port}, () => {
  console.log(`API on :${port}`);
});
