Feature: Friendship System

  As a user
  I want to be able to add and manage friends
  So that I can interact with specific users and see their posts

  Scenario: Sending a friend request
    Given there are two users with posts, Bob and Mary
    And I sign in as Bob
    When I visit the friends tab and add Mary's email
    And I click "Send friend request"
    Then a friend request should be sent to Mary
    And I should see "Friend request sent"

  Scenario: Accepting a friend request
    Given there are two users with posts, Bob and Mary
    And Bob has sent a friend request to Mary
    And I sign in as Mary
    When I visit my friend requests page
    And I click "Accept" on Bob's request
    Then Bob should be added to my friends list
    And I should see "Friend request accepted"

  Scenario: Rejecting a friend request
    Given there are two users with posts, Bob and Mary
    And Bob has sent a friend request to Mary
    And I sign in as Mary
    When I visit my friend requests page
    And I click "Reject" on Bob's request
    Then Bob should not be added to my friends list
    And I should see "Friend request rejected"

  Scenario: Viewing friends-only posts
    Given there are two users with posts, Bob and Mary
    And Bob and Mary are friends
    And there is another user named John with posts
    And I sign in as Bob
    When I visit the timeline
    Then I should see Mary's posts
    But I should not see John's posts

  Scenario: Removing a friend
    Given there are two users with posts, Bob and Mary
    And Bob and Mary are friends
    And I sign in as Bob
    When I visit my friends list
    And I click "Remove Friend" next to Mary
    Then Mary should be removed from my friends list
    And I should see "Friend removed"