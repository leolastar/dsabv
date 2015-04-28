class BuddyWalksController < ApplicationController
  before_action :set_buddy_walk, only: [:show, :edit, :update, :destroy]

  # GET /buddy_walks
  # GET /buddy_walks.json
  def index
    @buddy_walks = BuddyWalk.all
  end

  # GET /buddy_walks/1
  # GET /buddy_walks/1.json
  def show
  end

  # GET /buddy_walks/new
  def new
    @buddy_walk = BuddyWalk.new
  end

  # GET /buddy_walks/1/edit
  def edit
  end

  # POST /buddy_walks
  # POST /buddy_walks.json
  def create
    @buddy_walk = BuddyWalk.new(buddy_walk_params)

    respond_to do |format|
      if @buddy_walk.save
        format.html { redirect_to @buddy_walk, notice: 'Buddy walk was successfully created.' }
        format.json { render :show, status: :created, location: @buddy_walk }
      else
        format.html { render :new }
        format.json { render json: @buddy_walk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buddy_walks/1
  # PATCH/PUT /buddy_walks/1.json
  def update
    respond_to do |format|
      if @buddy_walk.update(buddy_walk_params)
        format.html { redirect_to @buddy_walk, notice: 'Buddy walk was successfully updated.' }
        format.json { render :show, status: :ok, location: @buddy_walk }
      else
        format.html { render :edit }
        format.json { render json: @buddy_walk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buddy_walks/1
  # DELETE /buddy_walks/1.json
  def destroy
    @buddy_walk.destroy
    respond_to do |format|
      format.html { redirect_to buddy_walks_url, notice: 'Buddy walk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_buddy_walk
      @buddy_walk = BuddyWalk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def buddy_walk_params
      params.require(:buddy_walk).permit(:title, :place, :description)
    end
end
