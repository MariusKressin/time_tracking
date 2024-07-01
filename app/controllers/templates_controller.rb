class TemplatesController < ApplicationController
  before_action :authenticate_permissions!, except: %i[index new create]

  def index
    @templates = Template.where(user_id: current_user.id)
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

  def edit; end

  def update
    @template.assign_attributes(template_params)
    return redirect_to @template, notice: 'Template saved!' if @template.save

    redirect_to edit_template_path(@template), alert: 'There was an error saving the template.'
  end

  def show; end

  def destroy
    return redirect_to '/templates', notice: 'Template deleted.' if @template.destroy

    redirect_to @template, alert: 'There was an error deleting the template.'
  end

  def add_to_hours
    failure = false
    @template.template_hours.each do |h|
      puts h.hours
      hour = Hour.new
      hour.user_id = current_user.id
      hour.topic_id = h.topic_id
      hour.begin = Time.now - (h.hours || 0) * 3_600 - (h.minutes || 0) * 60
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
    params.require(:template).permit(:title, :description).merge(user_id: current_user.id)
  end

  def authenticate_permissions!
    @template = Template.find(params[:id])

    error('You can\'t do that!', '/templates') if @template.user_id != current_user.id
  end
end
