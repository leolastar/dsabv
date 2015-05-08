class BuddySlotsController < ApplicationController
  before_action :admin_user, only: [:create, :destroy, :edit]

  def create
    @buddy_walks = BuddyWalk.all
    @buddy_walks.each do |buddy_walk|
      if buddy_walk.buddy_slot == nil
        buddy_walk.buddy_slot = BuddySlot.new(buddy_slot_params)
      end
      buddy_slot = buddy_walk.buddy_slot
      buddy_slot.update_attributes(buddy_slot_params)
      buddy_slot[:start_time].change(year:  buddy_walk.date.year,
                                     month: buddy_walk.date.month,
                                     day:   buddy_walk.date.day)
      buddy_slot[:end_time].change(year:  buddy_walk.date.year,
                                   month: buddy_walk.date.month,
                                   day:   buddy_walk.date.day)
      buddy_slot.save
      buddy_walk.save
    end
    flash[:success] = "Time slot added to all deals"
    redirect_to buddy_walks_path
  end

  def edit
    @buddy_walks = BuddyWalk.all
    @buddy_walks.each do |buddy_walk|
      buddy_slot = buddy_walk.buddy_slot
      buddy_slot.update_attributes(buddy_slot_params)
      buddy_slot[:start_time].change(year:  buddy_walk.date.year,
                                     month: buddy_walk.date.month,
                                     day:   buddy_walk.date.day)
      buddy_slot[:end_time].change(year:  buddy_walk.date.year,
                                   month: buddy_walk.date.month,
                                   day:   buddy_walk.date.day)
      buddy_slot.save
      buddy_walk.save
    end
    flash[:success] = "Time slot edit for all deals"
    redirect_to buddy_walks_path
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
