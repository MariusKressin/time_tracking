# frozen_string_literal: true

class TopicsController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]

  def index
    @topics = Topic.where(group_id: current_user.group_id)
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)
    return redirect_to @topic, notice: 'Topic saved!' if @topic.save

    redirect_to edit_topic_path(@topic), alert: 'There was an error saving the topic.'
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new
    @topic.assign_attributes(topic_params)
    @topic.group_id = current_user.group_id
    return redirect_to @topic, notice: 'Topic created!' if @topic.save

    redirect_to new_topic_path, alert: 'There was an error saving the topic.'
  end

  def destroy
    @topic = Topic.find(params[:id])
    return redirect_to '/topics', notice: 'Topic deleted.' if @topic.destroy

    redirect_to '/topics', alert: 'There was an error deleting the topic.'
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :description, :rate)
  end
end
