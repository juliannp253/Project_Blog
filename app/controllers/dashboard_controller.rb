class DashboardController < ApplicationController
  before_action :require_authentication

  def show
    @current_user = Current.user
  end
end
