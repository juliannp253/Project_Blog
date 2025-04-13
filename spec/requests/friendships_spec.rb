require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  before do
    @user = User.create(email_address: "juser@example.com", username: "Username", password: "123456", password_confirmation: "123456")
    @friend = User.create(email_address: "friend@example.com", username: "Friend", password: "123456", password_confirmation: "123456")
  end

  describe "When not signed in" do
    it "should not create a friendship" do
      post friendships_path, params: { friend_id: @friend.id }
      expect(response).to redirect_to(new_session_path)
    end

    it "should not accept a friend request" do
      post friend_requests_path, params: { friend_request: { friend_id: @friend.id } }
      expect(response).to redirect_to(new_session_path)
    end

    it "should not accept a friend request cancellation" do
      delete friendship_path(@friend.id)
      expect(response).to redirect_to(new_session_path)
    end

    it "should not view friendships" do
      get friendships_path
      expect(response).to redirect_to(new_session_path)
    end
  end
end
