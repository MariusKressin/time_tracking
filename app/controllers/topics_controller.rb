# frozen_string_literal: true

class TopicsController < ApplicationController
  def index
    @topics = Topic.where(user_id: current_user.id)
  end

  def show
    @topic = Topic.find(params[:id])
    redirect_to '/topics', alert: "You can't view that!" if @topic.user_id != current_user.id
  end

  def edit
    @topic = Topic.find(params[:id])
    redirect_to '/topics', alert: "You can't view that!" if @topic.user_id != current_user.id
  end

  def update
    @topic = Topic.find(params[:id])
    return redirect_to '/topics', alert: "You can't do that!" if @topic.user_id != current_user.id

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
    return redirect_to @topic, notice: 'Topic created!' if @topic.save

    redirect_to new_topic_path, alert: 'There was an error saving the topic.'
  end

  def destroy
    @topic = Topic.find(params[:id])
    return redirect_to '/topics', alert: "You can't do that!" if @topic.user_id != current_user.id

    return redirect_to '/topics', notice: 'Topic deleted.' if @topic.destroy

    redirect_to '/topics', alert: 'There was an error deleting the topic.'
  end

  def rate_in_dollars
    '%.2f' % (rate / 100.0)
  end

  def rate_in_dollars=(string)
    self.rate = (string.to_f * 100).round
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :description, :rate).merge(user_id: current_user.id)
  end
end
