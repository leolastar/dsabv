class TimeSlotsController < ApplicationController
  before_action :admin_user, only: [:create, :destroy]

  def create
    event = Event.find params[:event_id]
    @time_slot = event.time_slots.build(time_slot_params)
    @time_slot[:start_time].change(year:  event.date.year,
                                   month: event.date.month,
                                   day:   event.date.day)
    @time_slot[:end_time].change(year:  event.date.year,
                                 month: event.date.month,
                                 day:   event.date.day)
    @time_slot[:remaining_capacity] = @time_slot[:total_capacity]
    if @time_slot.save
      flash[:success] = "New time slot added."
      redirect_to event_path(event)
    else
      render 'static_pages/home'
    end
  end

  def destroy
    event = Event.find params[:event_id]
    @time_slot = TimeSlot.find params[:id]
    @time_slot.users.each do |user|
      EventMailer.event_cancellation(user, @time_slot).deliver
    end
    @time_slot.destroy
    flash[:info] = "Time slot deleted."
    redirect_to event_path(event)
  end
  
  def sort
    
    
  end

  private

    def time_slot_params
      params.require(:time_slot).permit(:start_time,
                                        :end_time,
                                        :total_capacity)
    end
end
