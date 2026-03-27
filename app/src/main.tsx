import {createRoot} from 'react-dom/client';
import {ZeroProvider} from '@rocicorp/zero/react';
import {schema} from './schema';
import {App} from './App';

createRoot(document.getElementById('root')!).render(
  <ZeroProvider
    userID="anon"
    cacheURL="http://localhost:4899"
    schema={schema}
    context={{sub: 'anon', userId: 'anon', role: null}}
    logLevel="info"
  >
    <App />
  </ZeroProvider>,
);
