class TemplateHoursController < ApplicationController
  def new
    @template_hour = TemplateHour.new
    @topics = Topic.where(user_id: current_user.id)
  end

  def create
    @template_hour = TemplateHour.new

    @template_hour.assign_attributes(template_hour_params)
    @template_hour.template_id = params[:template_id]
    return redirect_to @template_hour.template, notice: 'Hour template created!' if @template_hour.save

    redirect_to "/template/#{params[:template_id]}", alert: 'There was an error creating the hour template.'
  end

  def edit
    @template_hour = TemplateHour.find(params[:id])
    @topics = Topic.where(user_id: current_user.id)
  end

  def update
    @template_hour = TemplateHour.find(params[:id])
    return redirect_to '/templates' if @template_hour.template.user_id != current_user.id

    @template_hour.assign_attributes(template_hour_params)
    return redirect_to @template_hour.template, notice: 'Hour template saved!' if @template_hour.save

    redirect_to @template_hour.template, alert: 'There was an error saving the hour template.'
  end

  def destroy
    @template_hour = TemplateHour.find(params[:id])
    @template = @template_hour.template
    return reditect_to '/templates' if @template.user_id != current_user.id

    return redirect_to @template, notice: 'Hour template deleted!' if @template_hour.destroy

    redirect_to @template, alert: 'There was an error deleting the hour template.'
  end

  private

  def template_hour_params
    params.require(:template_hour).permit(:hours, :minutes, :topic_id, :template_id)
  end
end
