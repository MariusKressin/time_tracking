class AdminController < ApplicationController
  before_action :authenticate_admin!
  before_action :authenticate_group!, except: :index

  def index
    @users = User.where(group_id: current_user.group_id)
  end

  def show; end

  def edit
    redirect_to "/users/#{@user.id}", alert: 'You can\'t edit that!' if @user.role >= current_user.role
  end

  def update
    return redirect_to "/users/#{@user.id}", alert: 'You can\'t edit that!' if @user.role >= current_user.role

    @user.assign_attributes(admin_params)
    return redirect_to '/users', notice: 'User saved!' if @user.save

    redirect_to '/users/edit', alert: 'There was an error!'
  end

  def destroy
    return redirect_to "/users/#{@user.id}", alert: 'You can\'t delete that!' if @user.role >= current_user.role

    return redirect_to '/users', notice: 'User deleted!' if @user.destroy

    redirect_to "/users/#{params[:id]}", alert: 'There was an error!'
  end

  private

  def authenticate_group!
    @user = User.find(params[:id])

    error('You can\'t view that!', '/users') if @user.group_id != current_user.group_id
  end
end
