class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    @title = "Witaj w aplikacji Bilecik"
    @description = "Aplikacja pozwala na zarządzanie wydarzeniami oraz zakup biletów."
  end
end
