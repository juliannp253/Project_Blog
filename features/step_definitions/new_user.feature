Feature: New User

As a new user you want to create an account.

  Scenario: New user
    Given we have a user with no existing credentials
    When the user visits the sign up page
    And they enter "user120@example.com" and they enter "1235pass"
    And they click the sign up button
    Then the user should be redirected to the home page