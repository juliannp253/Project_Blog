class FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.friends
    
    if params[:q].present?
      @users_to_add = User.where("email_address LIKE ?", "%#{params[:q]}%")
                         .where.not(id: current_user.id)
                         .where.not(id: current_user.friends.pluck(:id))
                         .limit(10)
    end
  end
end
