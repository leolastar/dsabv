class BuddySlotController < ApplicationController
  before_action :admin_user, only: [:create, :destroy]

  def create
    buddy_walk = BuddyWalk.find params[:buddy_walk_id]
    @buddy_slot = buddy_walk.buddy_slots.build(buddy_slot_params)
    @buddy_slot[:start_time].change(year:  event.date.year,
                                   month: event.date.month,
                                   day:   event.date.day)
    @buddy_slot[:end_time].change(year:  event.date.year,
                                 month: event.date.month,
                                 day:   event.date.day)
    if @buddy_slot.save
      flash[:success] = "New time slot added."
      redirect_to buddy_walk_path(buddy_walk)
    else
      render 'static_pages/home'
    end
  end

  def destroy
    buddy_walk = BuddyWalk.find params[:buddy_walk_id]
    @buddy_slot = BuddySlot.find params[:id]
    @buddy_slot.users.each do |user|
      EventMailer.event_cancellation(user, @buddy_slot).deliver
    end
    @buddy_slot.destroy
    flash[:info] = "Time slot deleted."
    redirect_to event_path(buddy_walk)
  end

  private

  def buddy_slot_params
      params.require(:buddy_slot).permit(:start_time,
                                        :end_time)
  end
end
