class TemplatesController < ApplicationController
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

  def edit
    @template = Template.find(params[:id])
    redirect_to '/templates' if @template.user_id != current_user.id
  end

  def update
    @template = Template.find(params[:id])
    return redirect_to '/templates' if @template.user_id != current_user.id

    @template.assign_attributes(template_params)
    return redirect_to @template, notice: 'Template saved!' if @template.save

    redirect_to edit_template_path(@template), alert: 'There was an error saving the template.'
  end

  def show
    @template = Template.find(params[:id])
    return redirect_to '/templates' if @template.user_id != current_user.id
  end

  def destroy
    @template = Template.find(params[:id])
    return redirect_to '/templates' if @template.user_id != current_user.id

    return redirect_to '/templates', notice: 'Template deleted.' if @template.destroy

    redirect_to @template, alert: 'There was an error deleting the template.'
  end

  def add_to_hours
    @template = Template.find(params[:id])
    return redirect_to '/templates' if @template.user_id != current_user.id

    failure = false
    @template.template_hours.each do |h|
      puts h.hours
      hour = Hour.new
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
end
