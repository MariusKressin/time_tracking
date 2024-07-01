# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  layout 'application', only: %i[sub_new show edit update]
  before_action :authenticate_user!, only: %i[sub_new sub_create show edit update update_personal]
  before_action :authenticate_admin!, only: %i[sub_new sub_create]
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # Copied from the devise github page
  def create
    build_resource(sign_up_params)

    # NOT COPIED {
    @group = Group.new
    @group.title = 'Untitled Organization'
    @group.description = 'No description.'
    @group.save
    resource.primary_color = 'slate'
    resource.accent_color = 'indigo'
    resource.scheme = 'si'
    resource.role = 4
    resource.group_id = @group.id
    # }

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
    # end
  end

  # GET /users/sub
  def sub_new
    @user = User.new
  end

  # POST /users/sub
  def sub_create
    if sub_user_params[:role].to_i >= current_user.role
      return redirect_to '/users/sub', alert: 'You can\'t do that!'
    end

    @user = User.new
    @user.assign_attributes(sub_user_params)
    @user.primary_color = 'slate'
    @user.accent_color = 'indigo'
    @user.scheme = 'si'
    @user.group_id = current_user.group_id
    return redirect_to '/users', notice: 'User created!' if @user.save

    redirect_to '/users/sub', alert: 'Something went wrong!'
  end

  # GET /profile
  def show
    @user = current_user
  end

  # PUT /profile/personal
  def update_personal
    @user = current_user
    @user.assign_attributes(personal_user_params)
    return redirect_to '/edit', notice: 'Saved!' if @user.save

    redirect_to '/edit', alert: 'Something went wrong!'
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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[fname lname bio])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[fname lname bio])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def authenticate_admin!
    current_user.role >= 3
  end

  def sub_user_params
    params.require(:user).permit(:bio, :fname, :lname, :email, :password, :password_confirmation, :role)
  end

  def personal_user_params
    params.require(:user).permit(:bio, :fname, :lname, :email)
  end
end
