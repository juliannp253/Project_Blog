
Given('there are two users with posts, Bob and Mary') do
  @bob = User.create!(username: "Bob", email_address: "bob@example.com", password: 'password')
  @mary = User.create!(username: "Mary", email_address: "mary@example.com", password: 'password')

  @bob_post = Post.create!(title: 'Bob Post', content: 'This is Bob\'s post', user: @bob)
  @mary_post = Post.create!(title: 'Mary Post', content: 'This is Mary\'s post', user: @mary)
end

Given('I sign in as Bob') do
  visit new_session_path
  fill_in 'user_email', with: 'bob@example.com'
  fill_in 'user_password', with: 'password'
  click_button 'Login'
end

When('I am viewing one of my posts') do
  visit post_path(@bob_post)
end

# BEGIN Delete a post
When('I click Destroy and confirm') do
  expect(page).to have_content(@bob_post.title)

  click_button "Destroy this post"
end

Then('that post should be destroyed') do
  expect(Post.find_by(id: @bob_post.id)).to be_nil
  expect(page).to have_content('Post was successfully destroyed')
  expect(page).not_to have_content(@bob_post.content)
end
# END Delete a post

# BEGIN Edit a post
When('I click Edit') do
  click_link "Edit this post"
end

When('I submit the form') do
  click_button 'Update Post'
end
# <----------------------->
When('fill out the form with a new caption') do
  fill_in 'Title', with: 'Updated title by Bob'
  fill_in 'Content', with: 'Updated content by Bob'
end

Then('the post\'s caption should have changed') do
  expect(@bob_post.reload.title).to eq('Updated title by Bob')
  expect(@bob_post.reload.content).to eq('Updated content by Bob')
end

When('fill out the form with a new image url') do
  fill_in 'image_url', with: 'updated_bob_image.jpg'
  f.text_field :image_url
end

Then('the post\'s image should have changed') do
  expect(@bob_post.relaod.image_url).to eq('Updated_bob_image.jpg')
end
# END Edit a post

# BEGIN Liking a Post
When('I click Likes in Mary\'s first post') do
  within("#post_#{@mary_post.id}") do
    click_button 'Like'
  end
end

Then('I should have liked the post') do
  expect(page).to have_content('1 Like')
  expect(mary_posts.reload.likes.count).to eq(1)
  expect(mary_posts.likes.first.user).to eq(@bob)
end
# END Liking a Post

# BEGIN Make a post
When('I visit the homepage') do
  visit posts_path
end

When('I click New Post') do
  click_link 'New post'
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
# END Make a post

# BEGIN View Profiles
When('on the homepage') do
  visit posts_path
end

When('I click "Me"') do
  click_link 'My Profile', path(current_user)
end

Then('I should see my profile') do
  expect(page).to have_content(@bob.username)
  expect(page).to have_content(@bob.email)
  @bob.posts.each do |post|
    expect(page).to have_content(post.content)
  end
end

When('I am viewing the timeline') do
  visit posts_path
end

When('I click someones username') do
  click_link @mary.username
end

Then('I should see their profile') do
  expect(page).to have_content(@mary.email)
  @mary.posts.each do |post|
    expect(page).to have_content(post.content)
  end
end

When('I view Mary\'s profile') do
  visit path(@mary)
end

Then('I should see her email address') do
  expect(page).to have_content(@mary.email_address)
end

Then('I should see her posts') do
  @mary.posts.each do |post|
    expect(page).to have_content(post.content)
  end
end

Then('the posts should be in reverse order') do
  page_posts = all('.post-content').map(&:text)
  expect(@mary.posts.order(created_at: :desc).map(&:content)). ==(page_posts)
end
# END View Profiles

# BEGIN View Timeline
Then('everyone\'s posts should be in reverse order') do
  page_posts = all('.post-content').map(&:text)
  expect(@mary.posts.order(created_at: :desc).map(&:content) + @bob.posts.order(created_at: :desc).map(&:content)). ==(page_posts)
end
# END View Timeline

Then('I should see the everyone\'s posts') do
  @mary.posts.each { |post| expect(page).to have_content(post.content) }
  @bob.posts.each { |post| expect(page).to have_content(post.content) }
end
