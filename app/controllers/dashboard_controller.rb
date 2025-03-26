class DashboardController < ApplicationController
  before_action :require_authentication  # Make sure user exists

  def show
  end
end
