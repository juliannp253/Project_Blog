require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  before do
    @user = User.create(email_address: "juser@example.com", password: "1234", password_confirmation: "1234")
    @post = Post.create(title: "Post example", content: "This is content")
  end
  describe "When signed in" do
    before do
      sign_in @user
    end
    it "should display dashboard" do
      get root_path
      expect(response).to be_ok
    end
    it "should display all posts" do
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Post example")
    end
  end
  describe "When not signed in" do
    it "should not get dashboard" do
      get root_path
      expect(response).to redirect_to(new_session_path)
    end
    it "should not display any posts" do
      get posts_path
      expect(response).to redirect_to(new_session_path)
    end
  end
end
