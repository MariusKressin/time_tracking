# frozen_string_literal:true

class HoursController < ApplicationController
  before_action :set_config

  def index
    @hours = Hour.all
  end

  def edit
    @hour = Hour.find(params[:id])
    @topics = Topic.all
  end

  def update
    @hour = Hour.find(params[:id])
    @hour.assign_attributes(hour_params)
    redirect_to @hour if @hour.save
  end

  def new
    @hour = Hour.new
    @topics = Topic.all
  end

  def create
    @hour = Hour.new
    @hour.assign_attributes(hour_params)
    redirect_to @hour if @hour.save
  end

  def destroy
    @hour = Hour.find(params[:id])
    @hour.destroy
    redirect_to '/hours'
  end

  def show
    @hour = Hour.find(params[:id])
  end

  private

  def hour_params
    params.require(:hour).permit(:short_desc, :long_desc, :topic_id, :begin, :end, :auto_date)
  end

  def set_config
    @config = {}

    Config.all.each do |c|
      @config[c.key] = c.value
    end
  end
end
