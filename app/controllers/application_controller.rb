class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Via Devise: redirect the user to the login page if they're not signed in:
  # before_action :authenticate_user!
end
