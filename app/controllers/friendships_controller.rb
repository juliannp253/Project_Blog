class FriendshipsController < ApplicationController
  before_action :require_authentication
  before_action :set_user, only: [ :create ]

  def create
    @friendship = current_user.friendships.build(friend: @user)

    if @friendship.save
      redirect_to @user, notice: "Friend request sent to #{@user.email_address}"
    else
      redirect_to @user, alert: "Unable to send friend request"
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
