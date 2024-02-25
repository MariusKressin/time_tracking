class SettingsController < ApplicationController
  def index
    @config = Config.all
  end
end
