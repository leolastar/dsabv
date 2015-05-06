class BuddyWalksController < ApplicationController
  before_action :logged_in_user, only: [:register, :unregister]
  before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy, :add_buddy_slot]
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
    @buddy_walk = BuddyWalk.find(params[:id])
    @buddy_slot = @buddy_walk.buddy_slot
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
      flash[:success] = "Buddy walk deal updated."
      redirect_to @buddy_walk
    else
      render 'edit'
    end
  end

  def destroy
    @buddy_walk = BuddyWalk.find params[:id]
    if @buddy_walk.buddy_slot != nil
      @buddy_walk.buddy_slot.users.each do |user|
        EventMailer.event_cancellation_buddy(user, @buddy_walk.buddy_slot).deliver
      end
    end
    @buddy_walk.destroy
    flash[:info] = "BuddyWalk '#{@buddy_walk.title}' deleted."
		redirect_to buddy_walks_path
  end

  def add_buddy_slot
    @buddy_walk = BuddyWalk.all.first
    @buddy_walk.buddy_slot = BuddySlot.new
    @buddy_slot = @buddy_walk.buddy_slot
  end

  def edit_buddy_slot
    @buddy_walk = BuddyWalk.all.first
    @buddy_walk.buddy_slot = BuddySlot.new
    @buddy_slot = @buddy_walk.buddy_slot
  end

  def show_roster
    @buddy_walk = BuddyWalk.find(params[:id])
  end

  def register
    buddy_slot = BuddySlot.find(params[:buddy_slot_id])
    if current_user.buddy_slots.include?(buddy_slot)
      redirect_to registrations_user_path(current_user)
    else
      buddy_slot.save

      EventMailer.event_registration_buddy(current_user, buddy_slot).deliver

      current_user.buddy_slots << buddy_slot
      flash[:success] = "You have successfully registered the event."
      redirect_to registrations_user_path(current_user)
    end
  end
  
  def unregister
    buddy_slot = BuddySlot.find(params[:buddy_slot_id])
    if !current_user.buddy_slots.include?(buddy_slot)
      redirect_to registrations_user_path(current_user)
    else
      current_user.appointment(buddy_slot).destroy
      current_user.buddy_slots.delete(buddy_slot)
      flash[:success] = "You have successfully unregistered for this event."
      redirect_to registrations_user_path(current_user)
    end
  end

  def schedule
    @buddy_walk = BuddyWalk.new
  end

  def schedule_update
    @buddy_walk = BuddyWalk.new(buddy_walk_params)
    first = BuddyWalk.all.first
    @buddy_walk.date = first.date
    @buddy_walk.place = first.place
    if first.buddy_slot != nil
      @buddy_walk.buddy_slot = BuddySlot.new
      @buddy_walk.buddy_slot.start_time = first.buddy_slot.start_time
      @buddy_walk.buddy_slot.end_time = first.buddy_slot.end_time
      @buddy_walk.buddy_slot.save
    end 
    if @buddy_walk.save
      flash[:success] = "New Buddy Walk Deal has been created."
      redirect_to buddy_walk_path(@buddy_walk)
    else
      flash[:info] = "New Buddy walk deal did not save!"
      redirect_to schedule_buddy_walk_path
    end
  end

  def edit_schedule
    @buddy_walk = BuddyWalk.all.first
  end

  def edit_schedule_update
    BuddyWalk.all.each do |buddy_walk|
      buddy_walk.update_attributes(buddy_walk_params)
    end
    flash[:success] = "Buddy Walk schedule updated."
    redirect_to buddy_walks_path
  end

  private

    def buddy_walk_params
      params.require(:buddy_walk).permit(:title, :date, :place, :description)
    end

end
