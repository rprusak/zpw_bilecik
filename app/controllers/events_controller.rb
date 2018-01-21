class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def new

  end

  def index
    @events = Event.all
    puts @events
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    puts params
    @event = Event.new(params.require(:event).permit(:name, :description, :price, :event_date, :size, :image,
                                                     :for_children))

    @event.save
    redirect_to @event
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path
  end
end
