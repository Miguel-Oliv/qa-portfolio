*** Settings ***
Documentation     Sample login automation suite for portfolio purposes.
...               Runs against a public demo site (the-internet.herokuapp.com)
...               so it can be executed by anyone without needing test credentials
...               for a real system.
Library           SeleniumLibrary
Suite Setup       Open Test Browser
Suite Teardown    Close Browser
Test Setup        Go To Login Page

*** Variables ***
${URL}                https://the-internet.herokuapp.com/login
${BROWSER}             headlesschrome
${VALID USERNAME}      tomsmith
${VALID PASSWORD}      SuperSecretPassword!
${USERNAME FIELD}      id:username
${PASSWORD FIELD}      id:password
${FLASH MESSAGE}       id:flash

*** Test Cases ***
Valid Login Shows Success Message
    [Documentation]    Verifies that a valid username/password logs the user in
    ...                and lands them on the secure area.
    Input Text          ${USERNAME FIELD}    ${VALID USERNAME}
    Input Password       ${PASSWORD FIELD}    ${VALID PASSWORD}
    Submit Form
    Wait Until Element Contains    ${FLASH MESSAGE}    You logged into a secure area    timeout=10s
    Location Should Contain    /secure

Invalid Username Shows Error Message
    [Documentation]    Verifies that an unrecognized username is rejected
    ...                with a clear error and no session is created.
    Input Text          ${USERNAME FIELD}    not_a_real_user
    Input Password       ${PASSWORD FIELD}    ${VALID PASSWORD}
    Submit Form
    Wait Until Element Contains    ${FLASH MESSAGE}    Your username is invalid!    timeout=10s
    Location Should Contain    /login

Invalid Password Shows Error Message
    [Documentation]    Verifies that a wrong password is rejected and no session
    ...                is created. Note: this site intentionally shows the same
    ...                generic message for any invalid credential combination
    ...                (it does not confirm which field was wrong) — a common
    ...                security practice to avoid revealing valid usernames.
    Input Text          ${USERNAME FIELD}    ${VALID USERNAME}
    Input Password       ${PASSWORD FIELD}    wrong_password_123
    Submit Form
    Wait Until Element Contains    ${FLASH MESSAGE}    Your username is invalid!    timeout=10s
    Location Should Contain    /login

Empty Fields Do Not Submit Successfully
    [Documentation]    Verifies that submitting the form with empty fields
    ...                keeps the user on the login page with an error.
    Submit Form
    Wait Until Element Contains    ${FLASH MESSAGE}    Your username is invalid!    timeout=10s
    Location Should Contain    /login

*** Keywords ***
Open Test Browser
    [Documentation]    Opens the browser with an explicit window size — headless
    ...                Chrome can otherwise use a tiny default viewport that
    ...                causes click-based interactions to silently fail.
    Open Browser    ${URL}    ${BROWSER}
    Set Window Size    1920    1080

Go To Login Page
    [Documentation]    Ensures every test starts from a clean, freshly loaded
    ...                login page instead of relying on state left behind by
    ...                the previous test — avoids stale flash-message text.
    Go To    ${URL}
    Wait Until Element Is Visible    ${USERNAME FIELD}    timeout=10s
