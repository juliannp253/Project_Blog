Given "there are two users with posts, Bob and Mary" do
    @bob = create(:user_with_posts)
    @mary = create(:user_with_posts)
end

Given "I sign in as Bob" do
    visit new_user_session_path
    fill_in "user_email", with: @bob.email
    fill_in "user_password", with: "123greetings"
    click_on "Log in"
end

When "I visit the homepage" do
    visit root_path
end

Then "I should see the everyone's posts" do
    @posts = Post.all
    @posts.each do |p|
        expect(page.body).to include(p.image_url)
    end
end

Then "everyone's posts should be in reverse order" do
    @posts.reverse.each_with_index do |p, i|
        image = find(".order-#{i}")
        expect(image[:class]).to include("post-#{p.id}")
    end
end

Given "on the homepage" do
    visit root_path
end

When "I click {string}" do |text|
    click_on text
end

Then "I should see my profile" do
    expect(page).to have_current_path(user_posts_path(@bob))
end

Given "I am viewing the timeline" do
    visit root_path
end

When "I click someones username" do
    id = @mary.posts.first.id
    click_on "post-email-#{id}"
end

Then "I should see their profile" do
    expect(page).to have_current_path(user_posts_path(@mary))
end

When "I view Mary's profile" do
    visit user_posts_path(@mary)
end

Then "I should see her email address" do
    expect(page).to have_css("#user_email")
end

Then "I should see her posts" do
    @mary.posts.each do |p|
        expect(page.body).to include(p.image_url)
    end
end

Then "the posts should be in reverse order" do
    @mary.posts.reverse.each_with_index do |p, i|
        image = find(".order-#{i}")
        expect(image[:class]).to include("post-#{p.id}")
    end
end

When "fill out the form and submit" do
    fill_in "post_caption", with: "Cool post"
    fill_in "post_image_url", with: "http://www.google.com/cool.jpg"
    click_on "Create Post"
end

Then "I should have created a post" do
    expect(page).to have_content("Post was successfully created.")
end

Given "I am viewing one of my posts" do
    visit(user_post_path(@bob, @bob.posts.first))
end

When "fill out the form with a new caption" do
    fill_in "post_caption", with: "New Caption"
end

When "I submit the form" do
    click_on "Update Post"
end

Then "the post's caption should have changed" do
    expect(page).to have_content("Post was successfully updated.")
    expect(page).to have_content("New Caption")
end

When "fill out the form with a new image url" do
    fill_in "post_image_url", with: "http://www.aol.com/new.jpg"
end

Then "the post's image should have changed" do
    expect(page).to have_content("Post was successfully updated.")
    expect(page.body).to include("http://www.aol.com/new.jpg")
end

When 'I click "Destroy" and confirm' do
    click_on 'Destroy'
end

Then "that post should be deleted" do
    expect(page).to have_content("Post was successfully destroyed.")
end

When("I click Likes in Mary's first post") do
    @post = @mary.posts.first
    # PENDING find the link to the post
    like_link = find("#post-#{@post.id}-user-#{@post.user.id}")
    like_link.click
end

Then('I should have liked the post') do
    expect(page).to have_content("liked")
end
