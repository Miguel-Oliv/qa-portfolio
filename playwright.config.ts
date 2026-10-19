import { defineConfig } from '@playwright/test';

export default defineConfig({
  testDir: './tests',
  retries: 1,
  reporter: [['html'], ['list']],
  use: { baseURL: 'https://demo.playwright.dev/todomvc', trace: 'on-first-retry' },
});
