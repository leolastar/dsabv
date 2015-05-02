class StaticPagesController < ApplicationController
  def home
  	@article_top = Article.find_by_id(1)
  	@article_bottom = Article.find_by_id(2)
  end

  def calendar
  	@date = params[:date] ? Date.parse(params[:date]) : Date.today
    @events_by_date = Event.all.group_by(&:date)
  end
end
