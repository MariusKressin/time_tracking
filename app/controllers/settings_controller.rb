class SettingsController < ApplicationController
  def index
    @config = Config.all
  end

  def update
    @config = Config.find_by(key: params[:config][:key])
    @config.assign_attributes(config_params)
    redirect_to '/settings', notice: 'Settings saved!' if @config.save
  end

  private

  def config_params
    params.require(:config).permit(:value)
  end
end
