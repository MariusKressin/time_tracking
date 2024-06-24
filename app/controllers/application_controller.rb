class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def index; end

  private

  def authenticate_admin!
    current_user.role >= 3
  end
end
