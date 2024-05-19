class HomeController < ApplicationController
  layout 'home'

  def index
    if user_signed_in?
      redirect_to '/hours'
    else
      render 'home/index'
    end
  end
end
