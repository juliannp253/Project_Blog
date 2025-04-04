Feature: Make Post

  As a signed-in user I should be able to make a post in order to add new content

  Scenario: signed in and making a post
    Given there are two users with posts, Bob and Mary
    And I sign in as Bob
    When I visit the homepage
    And I click New Post
    And fill out the form and submit
    Then I should have created a post