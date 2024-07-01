class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def index; end

  private

  def authenticate_admin!
    error 'You can\'t access that!' unless current_user.role >= 3
  end

  def error(message, fallback = '/hours')
    redirect_back fallback_location: fallback, alert: message
  end
end
