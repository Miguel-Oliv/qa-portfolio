# QA Portfolio — Miguel Angel Olivera

Sample QA deliverables demonstrating test planning and automation approach.
Built to showcase working style for freelance/contract QA engagements —
not tied to any employer's proprietary code or data.

## Contents

- **`Test_Plan_Ecommerce_Example.md`** — Sample test plan for an e-commerce
  login/checkout flow: scope, approach, test cases, risk assessment.
- **`login_tests.robot`** — Robot Framework automation suite covering valid
  login, invalid username, invalid password, and empty-field submission.
  Runs against a public demo site so anyone can execute it directly.
- **`Reqres_API_Test_Collection.postman_collection.json`** — Postman collection
  testing a public REST API (reqres.in): GET (list, single, not-found), POST,
  PUT, and DELETE, each with assertions on status code, response shape, and
  data correctness.

## Running the automated Robot Framework suite

**Requirements:**
```
pip install robotframework robotframework-seleniumlibrary
```
Also requires Chrome and a matching `chromedriver` on your PATH.

**Run:**
```
robot login_tests.robot
```

This produces `log.html`, `report.html`, and `output.xml` in the working
directory — standard Robot Framework output for reviewing pass/fail results
and execution logs.

### Bugs found and fixed while building this suite

Real issues encountered and resolved during development — kept here
intentionally, since debugging process matters more than a suite that
"just passed" on the first try:

1. **Stale assertion / race condition:** early runs checked a flash message
   for visibility, but a leftover message from a previous test was still
   on screen, so the assertion passed against old text instead of the new
   one. Fixed by reloading the login page fresh before every test
   (`Test Setup`) and waiting for the *specific expected text* to appear
   (`Wait Until Element Contains`) instead of just checking visibility.
2. **Silent click failure in headless mode:** `Click Button` reported no
   error but the form never actually submitted — headless Chrome was
   using a small default viewport. Fixed by setting an explicit window
   size and switching to `Submit Form`, which submits via the DOM
   directly instead of depending on a visual click landing correctly.
3. **Incorrect assumption about app behavior:** initially expected a
   distinct "password is invalid" message for wrong-password attempts.
   The app actually returns the same generic "Your username is invalid!"
   message for any invalid credential combination — a common security
   practice to avoid confirming valid usernames. Test was corrected to
   match actual behavior instead of an assumption.

## Running the Postman collection

**Import into Postman:** File → Import → select
`Reqres_API_Test_Collection.postman_collection.json`. Run the whole
collection via the Collection Runner to see all test assertions execute.

**Or run headlessly with Newman:**
```
npm install -g newman
newman run Reqres_API_Test_Collection.postman_collection.json
```

## Approach

- Automation covers the critical path and top failure cases; broader edge
  cases are handled through manual exploratory testing (see test plan).
- Explicit waits are used instead of fixed sleeps to keep UI tests reliable
  against variable load times.
- API tests validate status codes, response structure, and data
  correctness — not just "did it return 200."
- Suite setup/teardown manage browser lifecycle; each UI test starts from
  a clean, freshly loaded page rather than depending on execution order.

## Contact

mangel.14om@gmail.com | www.linkedin.com/in/sdetmiguelolivera
