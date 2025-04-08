require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    @user1 = User.create(email_address: "user1@example.com", password: "123456", password_confirmation: "123456")
    @post1 = Post.create(title: "Post", content: "Post example for rspec")
  end
  describe "When signed in" do
    before do
      sign_in @user1
    end
    it "should display all posts" do
      get root_path
      expect(response.body).to include("Post")
    end
    it "should be able to create a post with valid attributes" do
      @post2 = { post: { title: "Test title", content: "Test content" } }

      expect {
        post new_post_path, params: @post2
    }.to change(Post, :count).by(1)

    expect {
      post new_post_path, params: { post: { title: nil, content: "Invalid post" } }
      }.not_to change(Post, :count)
     expect(response).to have_http_status(422)
    end
    it "should be able to edit posts with valid attributes" do
      patch "/posts/#(@post1.id)", params: { post: { title: nil } }
      expect(@post1.reload.title).to eq("Post example for rspec")
      expect(response).to have_http_status(422)
      end
    end
    it "should be able to delete posts" do
      expect {
        delete "/posts/#(@post1.id)"
    }.to change(Post, :count).by(-1)
    end
  end
  describe "When not signed in" do
    it "should not display any posts" do
      get posts_path
      expect(response).to redirect(new_session_path)
    end
    it "should not be able to create a new post" do
      get new_post_path
      expect(response).to redirect_to(new_session_path)
    end
    it "should not be able to edit a post" do
      get edit_post_path
      expect(response).to redirect_to(new_session_path)
    end
    it "should not be able to delete a post" do
      expect {
        delete "/posts/#(@post2)"
    }.to redirect(new_session_path)
  end
end
