# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    redirect_to root_path, alert: 'Only admins can create new accounts'
  end

  # POST /resource
  def create
    redirect_to root_path, alert: 'Only admins can create new accounts'
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  private

  def account_update_params
    original_params = params.require(:user).permit(:username, :password, :password_confirmation, :current_password,
                                                   :first_name, :last_name)
    if password_fields_present?(original_params)
      original_params.merge(valid_password: true)
    else
      original_params
    end
  end

  def password_fields_present?(params)
    params[:password].present? && params[:password_confirmation].present? && params[:current_password].present?
  end
end
