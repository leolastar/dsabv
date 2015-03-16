class EventsController < ApplicationController
  before_action :logged_in_user, only: [:register]
  before_action :admin_user,     only: [:edit, :update, :destroy, :show_roster, :add_time_slot]

  def index
    # Pagination
    @events = Event.paginate(page: params[:page])
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
    flash[:notice] = "Event '#{@event.title}' deleted."
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

    time_slot.remaining_capacity -= 1
    time_slot.save

    EventMailer.event_registration(current_user, time_slot).deliver

    current_user.time_slots << time_slot
    flash[:success] = "You have successfully registered the event."
    redirect_to registrations_user_path(current_user)
  end

  private

    def event_params
      params.require(:event).permit(:title,
                                    :date,
                                    :place,
                                    :description)
    end

end
