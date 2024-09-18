class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.valid_password = false
    if @user.save
      redirect_to admin_users_path, notice: 'User was successfully created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    @user.valid_password = false # Ensure they need to reset password on first login
    if @user.save
      redirect_to admin_users_path, notice: 'User was successfully updated'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path, notice: 'User was successfully deleted'
    else
      redirect_to admin_users_path, alert: 'Failed to delete user'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name, :admin)
  end

  def authenticate_admin!
    redirect_to root_path, alert: 'Access denied' unless current_user&.admin?
  end
end
