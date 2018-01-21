class TicketsController < ApplicationController
  before_action :authenticate_user!

  def all
    @tickets = current_user.tickets
  end

  def destroy
    @t = current_user.tickets.find(params[:id])
    @money = @t.places * @t.event.price
    @t.destroy

    @user = User.find(current_user.id)
    @user.money += @money
    @user.save

    redirect_to tickets_all_path, notice: "Your ticket has been deleted."
  end

  def create
    @event = Event.find(params[:event_id])

    @params = ticket_params
    @params["event_id"] = params[:event_id]
    @params["user_id"] = current_user.id


    @ticket = Ticket.new(@params)
    if @ticket.save
      redirect_to event_path(@event), notice: "You bought new ticket."
      return
    else
      @error_text = ""
      @ticket.errors.full_messages.each {|m| @error_text += m + ". "}
      redirect_to event_path(@event), alert: @error_text
      return
    end
  end

  def ticket_params
    params.require(:ticket).permit(:places)
  end
end
