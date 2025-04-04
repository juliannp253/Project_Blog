Feature: Deleting Posts

  As a signed-in user I should be able to delete one of my own posts so that no one can see it.

  Scenario: deleting a post from my profile
    Given there are two users with posts, Bob and Mary
    And I sign in as Bob
    And I am viewing one of my posts
    When I click Destroy and confirm
    Then that post should be destroyed