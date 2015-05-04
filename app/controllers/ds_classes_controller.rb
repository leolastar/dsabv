class DsClassesController < ApplicationController
  before_action :logged_in_user, only: [:register]
  before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy, :add_time_slot]
  before_action :staff_user,     only: [:show_roster]

  def index
    @article = Article.find_by_id(5)
    @ds_classes = DsClass.all

    if params[:query]
      @ds_classes = DsClass.search(params[:query])
      url = "/searchresults_classes?query=" + params[:query]
      redirect_to url
    else
      @ds_classes = []
    end

    @ds_classes = DsClass.paginate(page: params[:page])
  end

  def search
    @ds_classes = DsClass.all
    if params[:query]
      @ds_classes = DsClass.search(params[:query])
    else
      @ds_classes = []
    end
  end

  def show
    @ds_class = DsClass.find params[:id]
    @class_slots = @ds_class.class_slots.paginate(page: params[:page])
  end

  def new
    @ds_class = DsClass.new
  end

  def create
    @ds_class = DsClass.new(ds_class_params)
    if @ds_class.save
      flash[:success] = "New class has been created."
      redirect_to ds_class_path(@ds_class)
    else
      render 'new'
    end
  end

  def edit
    @ds_class = DsClass.find params[:id]
  end

  def update
    @ds_class = DsClass.find params[:id]
    if @ds_class.update_attributes(ds_class_params)
      flash[:success] = "Class updated."
      redirect_to @ds_class
    else
      render 'edit'
    end
  end

  def destroy
    @ds_class = DsClass.find params[:id]
    @ds_class.class_slots.each do |class_slot|
      class_slot.users.each do |user|
        EventMailer.event_cancellation_class(user, class_slot).deliver
      end
    end

    @ds_class.destroy
    flash[:success] = "Class '#{@ds_class.title}' deleted."
    redirect_to ds_classes_path
  end

  def add_time_slot
    @ds_class = DsClass.find params[:id]
    @class_slots = @ds_class.class_slots.paginate(page: params[:page])
    @class_slot = @ds_class.class_slots.build
  end

  def show_roster
    @ds_class = DsClass.find(params[:id])
  end

  def register
    class_slot = ClassSlot.find(params[:class_slot_id])

    class_slot.remaining_capacity -= 1
    class_slot.save

    EventMailer.event_registration_class(current_user, class_slot).deliver

    current_user.class_slots << class_slot
    flash[:success] = "You have successfully registered the class."
    redirect_to registrations_user_path(current_user)
  end

  def unregister
  end

  private

    def ds_class_params
      params.require(:ds_class).permit(:title,
                                    :place,
                                    :description,
                                    :start_date,
                                    :end_date)
    end
end

