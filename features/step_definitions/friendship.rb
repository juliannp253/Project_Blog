# Given("there are two users with posts, Bob and Mary") do
#   @bob = User.create!(username: "Bob", email_address: "bob@example.com", password: 'password')
#   @mary = User.create!(username: "Mary", email_address: "mary@example.com", password: 'password')
# end

# When("I sign in as Bob") do
#   visit new_session_path
#   fill_in "user_email", with: @bob.email_address
#   fill_in "user_password", with: @bob.password
#   click_button 'Login'
# end

When("I visit the friends tab and add Mary's email") do
  click_link_or_button "Friends"
  fill_in "Search by email or name...", with: @mary.email_address
end

When("I click Send friend request") do
  click_button "Search"
  expect(page).to have_content(@mary.email_address)
  expect(page).to have_button("Send Friend Request", wait: 5)
  click_button "Send Friend Request"
end

When("I should see Friend request sent") do
  expect(page).to have_contnet("Friend request sent")
end

Then("a friend request should be sent to Mary") do
  expect(@mary.freind_requests.any?).to eq(true)
end


Given("Bob and Mary are friends") do
  @bob.send_friend_request(@mary)
  @mary.accept_friend_request(@bob)
end

Given("there is another user named John with posts") do
  @john = User.create!(
    email_address: "john@example.com",
    password: 'password'
  )
  Post.create!(
    title: 'John Post',
    content: 'This is John\'s post',
    user: @john
  )
end

When("I visit my friend requests page") do
  visit friend_requests_path
end

When("I visit my friends list") do
  visit friends_path
end

When("I click {string} on Bob's request") do |action|
  within("#friend-request-#{@bob.id}") do
    click_button action
  end
end

When("I click {string} next to Mary") do |action|
  within("#friend-#{@mary.id}") do
    click_button action
  end
end

Then("a friend request should be sent to Mary") do
  expect(@mary.received_friend_requests.from_user(@bob)).to exist
end

Then("Bob should be added to my friends list") do
  expect(@mary.friends).to include(@bob)
  expect(@bob.friends).to include(@mary)
end

Then("Bob should not be added to my friends list") do
  expect(@mary.friends).not_to include(@bob)
  expect(@bob.friends).not_to include(@mary)
end

Then("I should see Mary's posts") do
  expect(page).to have_content(@mary_post.title)
  expect(page).to have_content(@mary_post.content)
end

Then("I should not see John's posts") do
  expect(page).not_to have_content("John Post")
  expect(page).not_to have_content("This is John's post")
end

Then("Mary should be removed from my friends list") do
  expect(@bob.friends).not_to include(@mary)
  expect(@mary.friends).not_to include(@bob)
end

When('I visit Mary\'s profile') do
  visit user_path(@mary)
end

When('I click {string}') do |string|
  click_link_or_button string
end

Then('I should see {string}') do |string|
  expect(page).to have_content(string)
end

Given('I sign in as Mary') do
  visit new_session_path
  fill_in 'user_email', with: 'mary@example.com'
  fill_in 'user_password', with: 'password'
  click_button 'Login'
end

When('I visit the timeline') do
  visit posts_path
end