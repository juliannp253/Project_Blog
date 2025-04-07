class FriendRequestsController < ApplicationController
  before_action :require_authentication

  def index
    @friend_requests = current_user.pending_friend_requests
  end
end