class UsersController < ApplicationController
  skip_before_action :require_authentication, only: [ :new, :create ]
  before_action :authenticate_user!, except: [ :new, :create ]
  before_action :set_user, except: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to after_authentication_url, notice: "Welcome, #{@user.email_address}!"
    else
      flash.now[:alert] = "There was an error creating your account."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def show
    @user = current_user
  end
  def update
    if password_blank? && @user.update(user_params_without_password)
      redirect_to root_path, notice: "Profile updated successfully."
    elsif !password_blank? && @user.update(user_params)
      redirect_to root_path, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email_address, :username, :password, :password_confirmation, :bio)
  end

  def user_params_without_password
    params.require(:user).permit(:email_address)
  end

  def password_blank?
    params[:user][:password].blank? && params[:user][:password_confirmation].blank?
  end
end
