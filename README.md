# AI-Assisted QA with Playwright + MCP + Claude Code

Test suite (UI + API) where an AI agent generates tests via **Playwright MCP** and a human reviews them.

## Setup
```bash
npm install && npx playwright install
claude mcp add playwright npx @playwright/mcp@latest   # or use .mcp.json
npm test
```

## AI workflow
1. Manual/exploratory pass to understand the feature and acceptance criteria.
2. Prompt the agent (Claude Code + Playwright MCP): *"Explore the app, propose test cases (happy path, boundary, negative), then write Playwright tests using role/test-id locators."*
3. **Human review** of every generated test:
   - Remove duplicated code (extract page objects/fixtures).
   - Simplify over-complicated logic.
   - Detect false positives (assertions that cannot fail, missing awaits, weak waits).
4. Run, stabilize flaky tests, commit.

## Review log (fill with real findings)
| Agent output issue | Fix applied |
|---|---|
| e.g. duplicated login steps in 4 tests | Moved to fixture |
| e.g. `waitForTimeout` instead of web-first assertion | Replaced with `expect(...).toBeVisible()` |

## Coverage
- UI: add, complete, empty input (negative)
- API: schema, create, 404 (negative)
