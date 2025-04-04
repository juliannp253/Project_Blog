Feature: Editing Posts

  As a signed-in user I should be able to edit one of my own posts in order to refine my content
  
  Scenario: signed in and editing a post's caption
    Given there are two users with posts, Bob and Mary
    And I sign in as Bob
    And I am viewing one of my posts
    When I click Edit
    And fill out the form with a new caption
    And I submit the form
    Then the post's caption should have changed

  Scenario: signed in and editing a post's image
    Given there are two users with posts, Bob and Mary
    And I sign in as Bob
    And I am viewing one of my posts
    When I click Edit
    And fill out the form with a new image url
    And I submit the form
    Then the post's image should have changed