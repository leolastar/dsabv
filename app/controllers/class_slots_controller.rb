class ClassSlotsController < ApplicationController
  before_action :admin_user, only: [:create, :destroy]

  def create
    ds_class = DsClass.find params[:ds_class_id]
    @class_slot = ds_class.class_slots.build(class_slot_params)
    @class_slot[:start_time].change(year:  ds_class.start_date.year,
                                   month: ds_class.start_date.month,
                                   day:   ds_class.start_date.day)
    @class_slot[:end_time].change(year:  ds_class.start_date.year,
                                 month: ds_class.start_date.month,
                                 day:   ds_class.start_date.day)
    @class_slot[:remaining_capacity] = @class_slot[:total_capacity]
    
    if @class_slot.save
      flash[:success] = "New time slot added."
      redirect_to ds_class_path(ds_class)
    else
      render 'static_pages/home'
    end
  end
  
  def add_day
    @class_slot = DsClass.find params[:id]
    @day = @class_slot.days.build
  end
  
  def remove_day
    
  end

  def destroy
    ds_class = DsClass.find params[:ds_class_id]
    @class_slot = ClassSlot.find params[:id]
    @class_slot.users.each do |user|
      EventMailer.event_cancellation(user, @class_slot).deliver
    end
    @class_slot.destroy
    flash[:notice] = "Time slot deleted."
    redirect_to ds_class_path(ds_class)
  end

  private

    def class_slot_params
      params.require(:class_slot).permit(:start_time,
                                         :end_time,
                                         :total_capacity)
    end
end
