class TicketsController < ApplicationController
  before_action :authenticate_user!

  def all
    @tickets = current_user.tickets
  end

  def destroy
    @t = current_user.tickets.find(params[:id])

    if @t.event.event_date.past?
      redirect_to tickets_all_path, alert: "You can not remove tickets for events from past."
      return
    end

    @money = @t.places * @t.event.price * 0.75
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

    # check if user has already ticket for this event
    if @event.tickets.exists?(user_id: current_user.id)
      redirect_to event_path(@event), alert: "You already have ticket for this event!"
      return
    end

    @ticket = Ticket.new(@params)

    # check if user has enough money
    if @ticket.places * @event.price > current_user.money
      redirect_to event_path(@event), alert: "You don't have enough money!"
      return
    end

    # check if there are enough places
    @taken = 0
    @event.tickets.each do |ticket|
      @taken += ticket.places
    end

    if @event.size - @taken < @ticket.places
      redirect_to event_path(@event), alert: "There are not enough places left for this event."
      return
    end

    if @ticket.save
      @user = User.find(current_user.id)
      @user.money -= @ticket.places * @event.price
      @user.save
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
