class BuddyWalksController < ApplicationController
  before_action :logged_in_user, only: [:register]
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
    @buddy_slot = BuddyWalk.find(params[:id]).buddy_slot
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
      flash[:success] = "Buddy updated."
      redirect_to @buddy_walk
    else
      render 'edit'
    end
  end

  def destroy
    @buddy_walk = BuddyWalk.find params[:id]
    @buddy_walk.buddy_slot.each do |buddy_slot|
      buddy_slot.users.each do |user|
        EventMailer.event_cancellation(user, buddy_slot).deliver
      end
    end
    @buddy_walk.destroy
    flash[:flash] = "BuddyWalk '#{@buddy_walk.title}' deleted."
		redirect_to buddy_walks_path
  end

  def add_buddy_slot
    @buddy_walk = BuddyWalk.find params[:id]
    @buddy_slot = @buddy_walk.buddy_slot.build
  end

  def show_roster
    @buddy_walk = BuddyWalk.find(params[:id])
  end

  def register
    buddy_slot = BuddySlot.find(params[:buddy_slot_id])
    
    buddy_slot.save

    EventMailer.event_registration(current_user, buddy_slot).deliver

    current_user.buddy_slot << buddy_slot
    flash[:success] = "You have successfully registered the event."
    redirect_to registrations_user_path(current_user)
  end

  def schedule
  end

  def edit_schedule
  end

  private

    def buddy_walk_params
      params.require(:buddy_walk).permit(:title, :date, :place, :description)
    end

end
