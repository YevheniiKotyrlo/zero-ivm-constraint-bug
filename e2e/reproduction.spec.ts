/**
 * Demonstrates the "Constraint should match partition key" crash.
 *
 * This test FAILS (red CI) while the bug exists.
 * When the bug is fixed, the test will PASS (green CI).
 *
 * Requires: docker compose up (PostgreSQL + zero-cache + API)
 */
import type { ConsoleMessage } from '@playwright/test';
import { test, expect, chromium } from '@playwright/test';

const APP_URL = process.env.APP_URL ?? 'http://localhost:5199';

test('.limit(0).related() should not crash during sync', async () => {
  test.setTimeout(30_000);

  const browser = await chromium.launch();
  const context = await browser.newContext();
  const page = await context.newPage();

  let constraintErrors = 0;
  page.on('console', (message: ConsoleMessage) => {
    if (message.text().includes('Constraint should match partition key')) {
      constraintErrors++;
    }
  });

  await page.goto(APP_URL);
  await page.waitForTimeout(10_000);

  console.log(`Result: ${constraintErrors > 0 ? 'CRASH' : 'CLEAN'} (${constraintErrors} errors)`);

  await context.close();
  await browser.close();

  expect(
    constraintErrors,
    'limit(0) + .related() should not crash — see README for details',
  ).toBe(0);
});
