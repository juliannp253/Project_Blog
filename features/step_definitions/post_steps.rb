Given('there are two users with posts, Bob and Mary') do
  @bob = User.create!(email_address: "bob@example.com", password: 'password')
  @mary = User.create!(email_address: "mary@example.com", password: 'password')
  Post.create!(title: 'Bob Post', content: 'This is Bob\'s post')
  Post.create!(title: 'Mary Post', content: 'This is Mary\'s post')
end

Given('I sign in as Bob') do
  visit new_session_path
  fill_in 'user_email', with: 'bob@example.com'
  fill_in 'user_password', with: 'password'
  click_button 'Login'
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

Given('I am viewing the timeline') do
  visit posts_path
end

When('I click Likes in Mary\'s first post') do
  within("#post_#{@mary_posts.id}") do
    click_button 'Like'
  end
end

Then('I should have liked the post') do
  expect(page).to have_content('1 Like')
  expect(mary_posts.reload.likes.count).to eq(1)
  expect(mary_posts.likes.first.user).to eq(@bob)
end

When('I am viewing one of my posts') do
  visit post_path(@bob_post)
end

When('I click {string}') do |button|
  click_button 'Edit'
end

When('I fill out the form with a new caption') do
  fill_in 'Caption', with: 'Updated caption by Bob'
end

When('I fill out the form with a new image url') do
  fill_in 'Image URL', with: 'updated_bob_image.jpg'
end

When('I submit the form') do
  click_button 'Submit'
end

Then('the post\'s caption should have changed') do
  expect(@bob_post.reload.title).to eq('Updated caption by Bob')
end

Then('the post\'s image should have changed') do
  expect(@bob_post.relaod.image_url).to eq('updated_bob_image.jpg')
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
  expect(Post.find_by(id: @bob_post.id)).to be_nil
  expect(page).to have_content('Post was successfully deleted')
  expect(page).not_to have_content(@bob_post.content)
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
