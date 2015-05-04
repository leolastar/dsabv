class EventsController < ApplicationController
  before_action :logged_in_user, only: [:register, :unregister]
  before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy, :add_time_slot]
  before_action :staff_user,     only: [:show_roster]

  def index
    @article = Article.find_by_id(3)
    @events = Event.all
    if params[:query]
      @events = Event.search(params[:query])

      url = "/searchresults_events?query=" + params[:query]
      redirect_to url
    else
      @events = []
    end

    @events = Event.paginate(page: params[:page])
  end

  def search
    @events = Event.all
    if params[:query]
      @events = Event.search(params[:query])
    else
      @events = []
    end
  end

  def show
    @event = Event.find params[:id]
    @time_slots = @event.time_slots.paginate(page: params[:page])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "New event has been created."
      redirect_to event_path(@event)
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find params[:id]
  end

  def update
    @event = Event.find params[:id]
    if @event.update_attributes(event_params)
      flash[:success] = "Event updated."
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find params[:id]
    @event.time_slots.each do |time_slot|
      time_slot.users.each do |user|
        EventMailer.event_cancellation(user, time_slot).deliver
      end
    end
    @event.destroy
    flash[:flash] = "Event '#{@event.title}' deleted."
    redirect_to events_path
  end

  def add_time_slot
    @event = Event.find params[:id]
    @time_slots = @event.time_slots.paginate(page: params[:page])
    @time_slot = @event.time_slots.build
  end

  def show_roster
    @event = Event.find(params[:id])
  end

  def register
    time_slot = TimeSlot.find(params[:time_slot_id])
    if current_user.time_slots.include?(time_slot)
      redirect_to registrations_user_path(current_user)
    else

      time_slot.remaining_capacity -= 1
      time_slot.save

      EventMailer.event_registration(current_user, time_slot).deliver

      current_user.time_slots << time_slot
      flash[:success] = "You have successfully registered the event."
      redirect_to registrations_user_path(current_user)
    end
  end

  def unregister
    time_slot = TimeSlot.find(params[:time_slot_id])
    if !current_user.time_slots.include?(time_slot)
      redirect_to registrations_user_path(current_user)
    else
      time_slot.remaining_capacity += 1
      time_slot.save
      current_user.appointment(time_slot).destroy
      current_user.time_slots.delete(time_slot)
      flash[:success] = "You have successfully unregistered for the event."
      redirect_to registrations_user_path(current_user)
    end
  end

  private

    def event_params
      params.require(:event).permit(:title,
                                    :date,
                                    :place,
                                    :description)
    end

end
