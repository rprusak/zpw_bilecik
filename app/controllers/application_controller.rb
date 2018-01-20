class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  def index
    @title = "Witaj w aplikacji Bilecik"
    @description = "Aplikacja pozwala na zarządzanie wydarzeniami oraz zakup biletów."
  end
end
