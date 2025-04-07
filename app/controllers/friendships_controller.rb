class FriendshipsController < ApplicationController
  before_action :require_authentication
  before_action :set_user, only: [ :create ]

  def create
    @friendship = current_user.friendships.build(friend: @user)

    if current_user.can_send_friend_request_to?(@user)
      @friendship = current_user.friendships.build(friend: @user, status: "pending")

      if @friendship.save
        redirect_to friends_path, notice: "Friend request sent to #{@user.email_address}"
      else
        redirect_to friends_path, alert: "Could not send friend request"
      end
    else
      redirect_to friends_path, alert: "Cannot send friend request to this user"
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.accept!
    redirect_to current_user, notice: "You are now friends with #{@friendship.user.email_address}"
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to current_user, notice: "Friendship removed"
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
