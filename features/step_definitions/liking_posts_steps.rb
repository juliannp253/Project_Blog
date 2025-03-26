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

Given('I am viewing the timeline') do
  visit posts_path
end

When('I click Likes in Mary\'s first post') do
  mary_post = @mary.posts.first
  within("#post_#{mary_post.id}") do
    click_button 'Like'
  end
end

Then('I should have liked the post') do
  mary_post = @mary.posts.first
  expect(mary_post.likes.count).to eq(1)
  expect(mary_post.likes.first.user).to eq(@bob)
end
