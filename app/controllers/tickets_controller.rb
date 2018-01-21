class TicketsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @ticket = @event.tickets.create(ticket_params)
    redirect_to event_path(@event)
  end

  def ticket_params
    params.require(:ticket).permit(:places)
  end
end
