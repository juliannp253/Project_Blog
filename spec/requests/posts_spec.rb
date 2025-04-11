require 'rails_helper'

RSpec.describe "Posts", type: :request do
  before do
    @user = User.create(email_address: "juser@example.com", password: "123456", password_confirmation: "123456")
    @post = Post.create(title: "Post example", content: "This is content", user_id: @user.id)
  end

  describe "When signed in" do
    before do
      post session_path, params: {
        username: @user.username,
        email_address: @user.email_address,
        password: "123456"
      }
    end
    it "should display dashboard" do
      get root_path
      expect(response).to be_ok
    end

    it "should create a post" do
      post posts_path, params: { post: { title: "New Post", content: "New content" } }
      get root_path
      expect(response.body).to include("New Post")
    end

    it "should display all posts" do
      post posts_path, params: { post: { title: @post.title, content: @post.content } }
      get root_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Post example")
    end

    it "should allow editing a post" do
      patch post_path(@post), params: { post: { title: "Updated Post", content: "Updated content" } }
      get root_path
      expect(response.body).to include("Updated Post")
    end

    it "should allow deleting a post" do
      post = Post.create(title: "Post to Delete", content: "This post will be deleted", user_id: @user.id)
      expect(post.id).not_to be_nil
      delete post_path(post)
      get root_path
      expect(response.body).not_to include(post.title)
    end
  end

  describe "When not signed in" do
    before do
      @post = Post.create(title: "Post to Edit or Delete", content: "Content that cannot be edited or deleted without signing in", user_id: @user.id)
    end

    it "should not get dashboard" do
      get root_path
      expect(response).to redirect_to(new_session_path)
    end

    it "should not display any posts" do
      get posts_path
      expect(response).to redirect_to(new_session_path)
    end

    it "should not create a post" do
      post posts_path, params: { post: { title: "Unauthorized Post", content: "Unauthorized content" } }
      expect(response).to redirect_to(new_session_path)
    end

    it "should not view a post" do
      get root_path
      expect(response).to redirect_to(new_session_path)
    end

    it "should not edit a post" do
      patch post_path(@post), params: { post: { title: "Unauthorized Edit", content: "Unauthorized content" } }
      expect(response).to redirect_to(new_session_path)
    end

    it "should not delete a post" do
      delete post_path(@post)
      expect(response).to redirect_to(new_session_path)
    end
  end
end
