# frozen_string_literal:true

require 'csv'
class HoursController < ApplicationController
  before_action :authenticate_permissions!, only: %i[update destroy show edit]

  def index
    @hours = Hour.where(user_id: current_user.id)
    @other_hours = Hour.where(user_id: current_user.visible_users)
    @total_hours = totals[:time].round
  end

  def edit
    @topics = Topic.all
    @minutes = -1
  end

  def update
    @hour.assign_attributes(hour_params)
    redirect_to @hour, notice: 'Time saved!' if @hour.save
  end

  def clear
    hours = Hour.where(user_id: current_user.id)
    failure = false
    hours.each do |h|
      failure = true unless h.destroy
    end
    return redirect_to '/hours', notice: 'Hours cleared!' unless failure

    redirect_to '/hours', alert: 'There was an error clearing the hours.'
  end

  def new
    @hour = Hour.new
    @topics = Topic.where(group_id: current_user.group_id)
    @minutes = params[:minutes].to_i || -1
  end

  def create
    @hour = Hour.new
    @hour.assign_attributes(hour_params)
    redirect_to @hour, notice: 'Hours logged!' if @hour.save
  end

  def destroy
    redirect_to '/hours', notice: 'Hours deleted.' if @hour.destroy
  end

  def show; end

  def html
    @topics = Topic.where(group_id: current_user.group_id)
    @totals = totals[:topics]
    @grand_total = totals[:grand]
    render 'export/html', layout: 'pdf'
  end

  def pdf
    html = HoursController
           .new
           .render_to_string({
                               template: '/export/html',
                               layout: 'pdf',
                               locals: {
                                 :@topics => Topic.all,
                                 :@totals => totals[:topics],
                                 :@grand_total => totals[:grand]
                               }
                             })
    send_data Grover.new(html).to_pdf, filename: "hours-pdf-#{Time.now.strftime('%m-%d-%Y')}", type: 'application/pdf'
  end

  def csv
    send_data to_csv, filename: "hours-export-#{Time.now.strftime('%m-%d-%Y')}", type: 'text/csv'
  end

  def detail
    html = HoursController
           .new
           .render_to_string({
                               template: '/export/detail',
                               layout: 'pdf',
                               locals: {
                                 :@topics => Topic.all,
                                 :@totals => totals[:topics]
                               }
                             })
    send_data Grover.new(html).to_pdf, filename: "hours-detail-pdf-#{Time.now.strftime('%m-%d-%Y')}", type: 'application/pdf'
  end

  private

  def hour_params
    params.require(:hour).permit(:short_desc, :long_desc, :topic_id, :begin, :end, :auto_date).merge(user_id: current_user.id)
  end

  def totals
    topic_totals = {}
    ttime = 0
    tmoney = 0
    Topic.where(group_id: current_user.group_id).each do |t|
      money = 0
      time = 0
      t.hours.each do |h|
        money += ((h.end - h.begin) * h.topic.rate / 360_000.0)
        time += ((h.end - h.begin) / 1.hour)
      end
      ttime += time
      tmoney += money
      topic_totals[t] = { topic_id: t.id, money:, rate: t.rate, time: ((time * 20).floor / 20.0) }
    end
    return { topics: topic_totals, time: ttime, grand: { time: ((ttime) * 20).floor / 20.0, money: tmoney } }
  end

  def to_csv
    sorted_hours = Hour.where(user_id: current_user.id).to_a.sort_by(&:begin)
    CSV.generate do |csv|
      csv << %w[Date Topic Description Time Value Rate]
      sorted_hours.each do |h|
        csv << [
          h.begin.strftime('%m/%d/%y'),
          h.topic.name, h.short_desc,
          "#{'%0.2f' % (((h.end - h.begin) * 20 / 1.hour).floor / 20.0)} hours",
          "$#{'%0.2f' % (h.topic.rate / 100.0)}",
          "$#{'%0.2f' % ((h.end - h.begin) * h.topic.rate / 360_000.0)}"
        ]
      end
      csv << ['---', '---', '---', '---', '---', '---']
      totals[:topics].each do |t|
        csv << [
          'Total:',
          t[0].name,
          '',
          "#{((t[1][:time]) * 20 / 1.hour).floor / 20.0} hours",
          "$#{'%0.2f' % (t[1][:rate] / 100.0)}",
          "$#{'%0.2f' % (t[1][:time] * t[1][:rate] / 100.0)}"
        ]
      end
    end
  end

  def authenticate_permissions!
    @hour = Hour.find(params[:id])
    error 'You can\'t access that!' unless @hour.user_id == current_user.id || @hour.user.role < current_user.role
  end
end
