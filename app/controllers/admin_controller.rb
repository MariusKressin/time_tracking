class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])

    redirect_to "/users/#{@user.id}", alert: 'You can\'t edit that!' if @user.role >= current_user.role
  end

  def update
    @user = User.find(params[:id])
    return redirect_to "/users/#{@user.id}", alert: 'You can\'t edit that!' if @user.role >= current_user.role

    @user.assign_attributes(admin_params)
    return redirect_to '/users', notice: 'User saved!' if @user.save

    redirect_to '/users/edit', alert: 'There was an error!'
  end

  def destroy
    @user = User.find(params[:id])
    return redirect_to "/users/#{@user.id}", alert: 'You can\'t delete that!' if @user.role >= current_user.role

    return redirect_to '/users', notice: 'User deleted!' if @user.destroy

    redirect_to "/users/#{params[:id]}", alert: 'There was an error!'
  end
end
