class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.where('role < ?', current_user.role)
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def authenticate_admin!
    current_user.role >= 3
  end
end
