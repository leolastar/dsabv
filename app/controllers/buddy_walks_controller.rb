class BuddyWalksController < ApplicationController
  before_action :logged_in_user, only: [:register]
  before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy, :add_time_slot]
  before_action :staff_user,     only: [:show_roster]

  def index
    @article = Article.find_by_id(4)
    @buddy_walks = BuddyWalk.all
  end

  def search
    @buddy_walks = BuddyWalk.all
    if params[:query]
      @buddy_walks = BuddyWalk.search(params[:query])
    else
      @buddy_walks = []
    end
  end

  def show
    @buddy_walk = BuddyWalk.find params[:id]
    @time_slots = @buddy_walk.time_slots.paginate(page: params[:page])
  end

  def new
    @buddy_walk = BuddyWalk.new
  end

  def create
    @buddy_walk = BuddyWalk.new(buddy_walk_params)
    if @buddy_walk.save
      flash[:success] = "New Buddy Walk has been created."
      redirect_to buddy_walk_path(@buddy_walk)
    else
      render 'new'
    end
  end

  def edit
    @buddy_walk = BuddyWalk.find params[:id]
  end

  def update
    @buddy_walk = BuddyWalk.find params[:id]
    if @buddy_walk.update_attributes(buddy_walk_params)
      flash[:success] = "Event updated."
      redirect_to @buddy_walk
    else
      render 'edit'
    end
  end

  def destroy
    @buddy_walk = BuddyWalk.find params[:id]
    @buddy_walk.time_slots.each do |time_slot|
      time_slot.users.each do |user|
        EventMailer.event_cancellation(user, time_slot).deliver
      end
    end
    @buddy_walk.destroy
    flash[:flash] = "Event '#{@buddy_walk.title}' deleted."
		redirect_to buddy_walks_path
  end

  def add_time_slot
    @buddy_walk = BuddyWalk.find params[:id]
    @time_slots = @buddy_walk.time_slots.paginate(page: params[:page])
    @time_slot = @buddy_walk.time_slots.build
  end

  def show_roster
    @buddy_walk = BuddyWalk.find(params[:id])
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

    def buddy_walk_params
      params.require(:buddy_walk).permit(:title, :date, :place, :description)
    end

end
