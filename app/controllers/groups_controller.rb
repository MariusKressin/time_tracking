class GroupsController < ApplicationController
  def index
    @group = current_user.group
    @users = User.where('role >= 3')
  end

  def edit
    @group = current_user.group
  end

  def update
    @group = current_user.group
    @group.assign_attributes(group_params)
    return redirect_to '/organization', notice: 'Info saved!' if @group.save

    redirect_to '/organization/edit', alert: 'There was a problem!'
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
