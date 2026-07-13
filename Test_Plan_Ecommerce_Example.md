# Test Plan: E-Commerce Login & Checkout Flow

**Author:** Miguel Angel Olivera
**Project (sample):** Demo E-Commerce Platform
**Version:** 1.0

---

## 1. Introduction

This test plan covers the login and checkout flow of a typical e-commerce
web application. It is written as a sample deliverable to demonstrate test
planning and test case design approach for QA/SDET engagements.

## 2. Scope

**In scope:**
- User authentication (login, invalid login, session handling)
- Add to cart and cart management
- Checkout flow (shipping info, payment, order confirmation)

**Out of scope:**
- Admin/backend panel
- Third-party payment gateway internals (only integration points are tested)
- Load/performance testing (covered in a separate plan if needed)

## 3. Test Objectives

- Verify users can log in and log out successfully under valid and invalid conditions
- Verify cart correctly reflects added/removed items and quantities
- Verify checkout completes end-to-end and produces a valid order confirmation
- Verify appropriate error handling and messaging at each step

## 4. Test Approach

| Layer | Approach |
|---|---|
| UI | Manual exploratory + automated regression (Selenium/Robot Framework) |
| API | Postman collection validating backend responses independent of UI |
| Data | SQL checks confirming order/cart records persist correctly |

Automated tests cover the critical path (happy path + top 3 failure cases per
feature). Edge cases and usability issues are covered manually, since they
change frequently and are higher-value for human judgment.

## 5. Entry / Exit Criteria

**Entry criteria:**
- Test environment deployed and stable
- Test data (user accounts, product catalog) seeded

**Exit criteria:**
- 100% of critical-path test cases executed
- No open Severity 1 (blocker) or Severity 2 (critical) defects
- All Severity 3+ defects logged with reproduction steps

## 6. Sample Test Cases

| ID | Title | Steps | Expected Result | Priority |
|---|---|---|---|---|
| TC-01 | Valid login | 1. Go to login page 2. Enter valid credentials 3. Click Login | User is redirected to homepage/dashboard; session is created | High |
| TC-02 | Invalid password | 1. Enter valid email + wrong password 2. Click Login | Error message shown; user is not logged in; no session created | High |
| TC-03 | Empty required fields | 1. Leave email/password blank 2. Click Login | Field-level validation errors shown; form does not submit | Medium |
| TC-04 | Add item to cart | 1. Select product 2. Click "Add to Cart" | Cart icon updates count; item appears in cart with correct price/qty | High |
| TC-05 | Update quantity in cart | 1. Open cart 2. Change quantity of an item | Line total and cart total recalculate correctly | High |
| TC-06 | Remove item from cart | 1. Open cart 2. Remove an item | Item disappears; cart total updates; cart count decreases | Medium |
| TC-07 | Checkout with valid payment | 1. Proceed to checkout 2. Enter valid shipping + payment info 3. Submit order | Order confirmation page shown with correct order summary; confirmation email/record created | High |
| TC-08 | Checkout with invalid card | 1. Proceed to checkout 2. Enter invalid card number 3. Submit | Payment error shown; order is NOT created; user can retry | High |
| TC-09 | Checkout with empty cart | 1. Navigate directly to checkout with no items in cart | User is redirected to cart/catalog with a message; checkout is blocked | Medium |
| TC-10 | Session timeout during checkout | 1. Start checkout 2. Let session expire 3. Submit order | User is prompted to re-authenticate; cart contents are preserved | Low |

## 7. Test Data Requirements

- At least 2 valid user accounts (different roles if applicable)
- At least 1 locked/disabled account for negative testing
- Product catalog with in-stock and out-of-stock items
- Test payment card numbers (sandbox/test mode only — never real card data)

## 8. Risks & Mitigations

| Risk | Mitigation |
|---|---|
| Payment gateway sandbox instability | Mock payment responses for automated regression; reserve sandbox for manual smoke tests |
| Test data drift between environments | Seed scripts run before each test cycle; do not rely on manually curated data |
| Flaky UI automation due to async loading | Use explicit waits tied to state changes, not fixed sleeps |

## 9. Deliverables

- This test plan
- Automated regression suite (Robot Framework — see companion repo)
- Postman collection for API-level checks
- Defect log with severity classification
