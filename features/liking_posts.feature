Feature: Like posts

Scenario: I should be able to like other people posts
    Given there are two users with posts, Bob and Mary
    And I sign in as Bob
    And I am viewing the timeline
    When I click Likes in Mary's first post
    Then I should have liked the post
