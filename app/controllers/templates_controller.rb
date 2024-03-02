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
    return redirect_to @template, notice: 'Template created!' if @template.save

    redirect_to '/templates/new', alert: 'There was an error creating the template.'
  end

  def edit
    @template = Template.find(params[:id])
  end

  def update
    @template = Template.find(params[:id])
    @template.assign_attributes(template_params)
    return redirect_to @template, notice: 'Template saved!' if @template.save

    redirect_to edit_template_path(@template), alert: 'There was an error saving the template.'
  end

  def show
    @template = Template.find(params[:id])
  end

  def destroy
    @template = Template.find(params[:id])
    return redirect_to '/templates', notice: 'Template deleted.' if @template.destroy

    redirect_to @template, alert: 'There was an error deleting the template.'
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
    return redirect_to '/hours', notice: 'Hours logged!' unless failure

    redirect_to @template, alert: 'There was an error logging the hours.'
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
