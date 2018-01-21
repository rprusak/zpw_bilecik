class TicketsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @ticket = @event.tickets.create(ticket_params)
    @message = "dupa dupa"
    redirect_to event_path(@event), notice: "You bought new ticket."
  end

  def ticket_params
    params.require(:ticket).permit(:places)
  end
end
