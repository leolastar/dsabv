class StaticPagesController < ApplicationController
  def home
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events_by_date = Event.all.group_by(&:date)
  end
end
