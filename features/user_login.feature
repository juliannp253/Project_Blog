Feature: User Login

  Scenario: User can log in with valid credentials
    Given a user exists with a username "username", email "user@example.com", and password "password123"
    When the user visits the login page
    And the user enters "user@example.com" in the email field
    And the user enters "password123" in the password field
    And the user clicks the login button
    Then the user should be redirected to the dashboard
    
