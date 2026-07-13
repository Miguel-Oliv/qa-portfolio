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

## Running the automated suite

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

## Approach

- Automation covers the critical path and top failure cases; broader edge
  cases are handled through manual exploratory testing (see test plan).
- Explicit waits are used instead of fixed sleeps to keep tests reliable
  against variable load times.
- Suite setup/teardown manage browser lifecycle; a logout keyword resets
  session state between test cases so tests don't depend on execution order.

## Contact

mangel.14om@gmail.com | www.linkedin.com/in/sdetmiguelolivera
