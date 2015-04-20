
$temp
$temp2
class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy



  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    unless logged_in?
  	  @user = User.new
    else
      redirect_to user_path(current_user)
    end
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
    

    session[:user_id] = @user.id
      @user.send_activation_email
     # flash[:info] = "Please check your email to activate your account."
     redirect_to reg_url
     @user.send_activation_email
    else
      render 'new'
    end
  end

def registration_confirmation
    #temp = session[:user_id]
   # id = temp
    
    #@user= User.new  
   @user = User.new
   @u = User.find(session[:user_id])
   
    #@user.send_activation_email
     #if @u.save
   # @u.send_activation_email
   # end
  
  
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def show_registrations
    user = User.find(params[:id])
    @registrations = user.time_slots
  end

  private

    def user_params
      params.require(:user).permit(:name,
                                   :email,
                                   :password,
                                   :password_confirmation,
                                   :address,
                                   :phone_number,
                                   :emergency_contact_name,
                                   :emergency_contact_phone)
    end

    # Before filters

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
