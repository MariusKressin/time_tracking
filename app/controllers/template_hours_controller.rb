class TemplateHoursController < ApplicationController
  before_action :set_config

  def new
    @template_hour = TemplateHour.new
    @topics = Topic.all
  end

  def create
    @template_hour = TemplateHour.new
    @template_hour.assign_attributes(template_hour_params)
    @template_hour.template_id = params[:template_id]
    redirect_to @template_hour.template if @template_hour.save
  end

  def edit
    @template_hour = TemplateHour.find(params[:id])
    @topics = Topic.all
  end

  def update
    @template_hour = TemplateHour.find(params[:id])
    @template_hour.assign_attributes(template_hour_params)
    redirect_to @template_hour.template if @template_hour.save
  end

  def destroy
    @template_hour = TemplateHour.find(params[:id])
    @template = @template_hour.template
    redirect_to @template if @template_hour.destroy
  end

  private

  def template_hour_params
    params.require(:template_hour).permit(:hours, :minutes, :topic_id, :template_id)
  end

  def set_config
    @config = {}

    Config.all.each do |c|
      @config[c.key] = c.value
    end
  end
end
