class HomeController < ApplicationController
  layout 'home'
  def index
    render 'home/index'
  end
end
