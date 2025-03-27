Feature: Like posts

    A user should be able to show support for posts the enjoy so they should be able to like a post

Scenario: I should be able to star other people posts
    Given there are two users with posts, Bob and Mary
    And I sign in as Bob
    And I am viewing the timeline
    When I click Likes in Mary's first post
    Then I should have liked the post
