class EventsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event created!"
      redirect_to user_path(@event.creator)
    else
      render 'static_pages#home'
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "Event removed!"
    redirect_to request.referrer || root_url
  end

  def index
    #@events = Event.all
    @events_upcoming = Event.all.upcoming
    @events_past = Event.all.past
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees

  end


  private

    def event_params
      params.require(:event).permit(:location, :description, :date, :title)
    end

    def correct_user
      @event = current_user.events.find_by(id: params[:id])
      redirect_to root_url if @event.nil?
    end
end
