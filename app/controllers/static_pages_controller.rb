class StaticPagesController < ApplicationController
  def home
  end

  def calendar
  	@date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events_by_date = Event.all.group_by(&:date)
  end

  def edit_text_box
  	@text = params[:id]
  end
end
