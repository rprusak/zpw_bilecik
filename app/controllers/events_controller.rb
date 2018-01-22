class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:create, :destroy]
  def new

  end

  def index
    @events = Event.all
    puts @events
  end

  def show
    @event = Event.find(params[:id])

    @taken = 0
    @event.tickets.each do |ticket|
      @taken += ticket.places
    end

  end

  def create
    @event = Event.new(params.require(:event).permit(:name, :description, :price, :event_date, :size, :image,
                                                     :for_children))

    @event.save
    redirect_to @event
  end

  def destroy
    if !current_user.is_admin
      redirect_to events_path, alert: "Only administrator can remove events!"
      return
    end

    @event = Event.find(params[:id])
    @event.tickets.each {|t| t.destroy}
    @event.destroy

    redirect_to events_path
  end

  def correct_user
    if !current_user.is_admin
      redirect_to events_path, alert: "Only administrator can perform this action!"
    end
  end

end
