Given('there are two users with posts, Bob and Mary') do
  @bob = User.create!(name: 'Bob', email: 'bob@example.com', password: 'password')
  @mary = User.create!(name: 'Mary', email: 'mary@example.com', password: 'password')
  @bob.posts.create!(title: 'Bob Post', content: 'This is Bob\'s post')
  @mary.posts.create!(title: 'Mary Post', content: 'This is Mary\'s post')
end

Given('I sign in as Bob') do
  visit new_session_path
  fill_in 'Email', with: 'bob@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Sign In'
end

Given('on the homepage') do
  visit root_path
end

When('I click {string}') do |link_text|
  click_link link_text
end

Then('I should see my profile') do
  expect(page).to have_content(@bob.username)
  expect(page).to have_content(@bob.email)
  @bob.posts.each do |post|
    expect(page).to have_content(post.content)
  end
end

Given('I am viewing the timeline') do
  visit '/timeline'
end

When('I click someones username') do
  click_link @mary.username
end

Then('I should see their profile') do
  expect(page).to have_content(@mary.username)
  expect(page).to have_content(@mary.email)
  @mary.posts.each do |post|
    expect(page).to have_content(post.content)
  end
end

When('I view Mary\'s profile') do |username|
  user = User.find_by(username: username)
  visit "/users/#{user.id}"
end

Then('I should see her email address') do
  expect(page).to have_content(@mary.email)
end

Then('I should see her posts') do
  @mary.posts.each do |post|
    expect(page).to have_content(post.content)
  end
end

Then('the posts should be in reverse order') do
  sorted_posts = @mary.posts.order(created_at: :desc).map(&:content)
  page_posts = all('.post-content').map(&:text)
  expect(page_posts).to eq(sorted_posts)
end
