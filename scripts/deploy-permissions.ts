import { execSync } from 'node:child_process';

console.log('Deploying Zero permissions...');
execSync(
  'npx zero-deploy-permissions --schema-path schema/schema.ts --upstream-db postgresql://user:password@localhost:5499/postgres',
  { stdio: 'inherit' },
);
console.log('Done.');
