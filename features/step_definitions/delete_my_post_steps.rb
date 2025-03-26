Given('there are two users with posts, {string} and {string}') do |user1, user2|
  @user1 = User.create!(username: user1, email: "#{user1}@example.com", password: 'password')
  @user2 = User.create!(username: user2, email: "#{user2}@example.com", password: 'password')
  Post.create!(user: @user1, content: "#{user1}'s first post")
  Post.create!(user: @user2, content: "#{user2}'s first post")
end

Given('I sign in as {string}') do |username|
  visit '/login'
  fill_in 'Username', with: username
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

Given('I am viewing one of my posts') do
  visit post_path(@bob_post)
end

When('I click {string} and confirm') do |button_text|
  accept_confirm do
    click_link_or_button button_text
  end
end

Then('that post should be deleted') do
  expect(Post.exists?(@bob_post.id)).to be_falsey
  expect(page).to have_content('Post was successfully deleted')
end
