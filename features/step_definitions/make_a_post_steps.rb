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

When('I visit the homepage') do
  visit root_path
end

When('I click {string}') do |link|
  click_link link
end

When('fill out the form and submit') do
  fill_in 'Title', with: 'My New Post'
  fill_in 'Content', with: 'This is the content of my new post.'
  click_button 'Create Post'
end

Then('I should have created a post') do
  expect(Post.last.title).to eq('My New Post')
  expect(Post.last.content).to eq('This is the content of my new post.')
  expect(Post.last.user).to eq(@bob)
end
