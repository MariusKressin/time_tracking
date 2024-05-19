class SettingsController < ApplicationController
  def update
    u = current_user
    u.assign_attributes(config_params)
    redirect_to '/settings', notice: 'Settings saved!' if u.save
  end

  private

  def config_params
    pcol = 'slate'
    acol = 'indigo'

    case params[:user][:scheme]
    when 'ri'
      pcol = 'red'
      acol = 'indigo'
    when 'ro'
      pcol = 'red'
      acol = 'orange'
    when 'tb'
      pcol = 'teal'
      acol = 'blue'
    when 'ib'
      pcol = 'indigo'
      acol = 'blue'
    when 'bt'
      pcol = 'blue'
      acol = 'teal'
    when 'si'
      pcol = 'slate'
      acol = 'indigo'
    end

    params.require(:user).permit(:scheme).merge({ primary_color: pcol, accent_color: acol })
  end
end
