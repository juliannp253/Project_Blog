Given('there are two users with posts, Bob and Mary') do
  @bob = User.create!(username: 'Bob', password: 'password')
  @mary = User.create!(username: 'Mary', password: 'password')
  @bob_post = @bob.posts.create!(caption: "Bob's original post', image_url: 'bob_image.jpg")
  @mary_post = @mary.posts.create!(caption: "Mary's post', image_url: 'mary_image.jpg")
end

When('I sign in as Bob') do
  visit login_path
  fill_in 'Username', with: 'Bob'
  fill_in 'Password', with: 'password'
  click_button 'Log In'
end

When('I am viewing one of my posts') do
  visit post_path(@bob_post)
end

When('I click {string}') do |button|
  click_button 'Edit'
end

When("I fill out the form with a new caption") do
  fill_in 'Caption', with: 'Updated caption by Bob'
end

When("I fill out the form with a new image url") do
  fill_in 'Image URL', with: 'updated_bob_image.jpg'
end

When('I submit the form') do
  click_button 'Submit'
end

Then('the post\'s caption should have changed') do
  @bob_post.reload
  expect(@bob_post.caption).to eq('Updated caption by Bob')
end

Then('the post\'s image should have changed') do
  @bob_post.reload
  expect(@bob_post.image_url).to eq('updated_bob_image.jpg')
end
