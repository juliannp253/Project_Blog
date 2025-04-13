require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "When not signed in" do
    let!(:user) { User.create(username: "testuser", email_address: "test@example.com", password: "password123") }

    it "should not allow access to edit profile page" do
      get edit_profile_path(user)
      expect(response).to redirect_to(new_session_path)
    end

    it "should not allow updating the profile" do
      patch update_profile_path(user), params: { user: { username: "newusername" } }
      expect(response).to redirect_to(new_session_path)
    end

    it "should not allow viewing the user profile" do
      get user_path(user)
      expect(response).to redirect_to(new_session_path)
    end
  end
end
