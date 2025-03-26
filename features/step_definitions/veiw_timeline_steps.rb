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

Given('on the homepage') do
  visit root_path
end

Then('I should see the everyone\'s posts') do
  @mary.posts.each { |post| expect(page).to have_content(post.content) }
  @bob.posts.each { |post| expect(page).to have_content(post.content) }
end

Then('everyone\'s posts should be in reverse order') do
  posts_content = @mary.posts.order(created_at: :desc).pluck(:content) + @bob.posts.order(created_at: :desc).pluck(:content)
  page_posts = page.all('.post-content').map(&:text)
  expect(page_posts).to eq(posts_content)
end
