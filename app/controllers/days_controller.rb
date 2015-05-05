class DaysController < ApplicationController
  before_action :admin_user, only: [:create, :destroy]

  def create
    @class_slot = ClassSlot.find params[:class_slot_id]
    ds_class = @class_slot.ds_class
    @class_slot.days << Day.new(day_params)
    
    if @class_slot.save
      flash[:success] = "New day added."
      redirect_to ds_class_path(ds_class)
    else
      render 'static_pages/home'
    end
  end

  def destory
    ds_class = DsClass.find params[:class_id]
    @day = Day.find params[:day][:id]
    @day.destroy
    flash[:info] = "Removed day."
    redirect_to ds_class_path(ds_class)
  end

  private

    def day_params
      params.require(:day).permit(:day)
    end
end
