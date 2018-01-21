class MoneyController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def create
    @user = User.find(current_user.id)
    @user.money += 1000
    @user.save
    redirect_to money_index_path, notice: "New founds have been added to your account."
  end

end
