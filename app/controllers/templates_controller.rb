class TemplatesController < ApplicationController
  before_action :set_config

  def index
    @templates = Template.all
  end

  def new
    @template = Template.new
  end

  def create
    @template = Template.new
    @template.assign_attributes(template_params)
    redirect_to @template if @template.save
  end

  def edit
    @template = Template.find(params[:id])
  end

  def update
    @template = Template.find(params[:id])
    @template.assign_attributes(template_params)
    redirect_to @template if @template.save
  end

  def show
    @template = Template.find(params[:id])
  end

  def destroy
    @template = Template.find(params[:id])
    redirect_to '/templates', notice: 'Template deleted.' if @template.destroy
  end

  def add_to_hours
    @template = Template.find(params[:id])
    failure = false
    @template.template_hours.each do |h|
      hour = Hour.new
      hour.topic_id = h.topic_id
      hour.begin = Time.now - h.hours * 3_600 - h.minutes * 60
      hour.end = Time.now
      hour.short_desc = "From #{@template.title}"
      hour.long_desc = "From #{@template.title}"
      failure = true unless hour.save
    end
    redirect_to '/hours' unless failure
  end

  private

  def template_params
    params.require(:template).permit(:title, :description)
  end

  def set_config
    @config = {}

    Config.all.each do |c|
      @config[c.key] = c.value
    end
  end
end
