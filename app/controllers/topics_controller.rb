# frozen_string_literal: true

class TopicsController < ApplicationController
  def index
    @topics = Topic.all
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
    redirect_to @topic if @topic.save
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new
    @topic.assign_attributes(topic_params)
    redirect_to @topic if @topic.save
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to '/topics'
  end

  def rate_in_dollars
    puts 'Hi!!!!\n\n\n\n\n\n'
    '%.2f' % (rate / 100.0)
  end

  def rate_in_dollars=(string)
    puts 'Hoophoop\n\n\n\n\n\n'
    self.rate = (string.to_f * 100).round
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :description, :rate)
  end
end
