class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @events ||= @user.events
    @event = current_user.events.build if logged_in?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Private Events!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password,
  									:password_confirmation)
  	end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
