#
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Via Devise: redirect the user to the login page if they're not signed in:
  # before_action :authenticate_user!

  #============== DEVISE Authentication gem related ===========================
  # per doc at: https://github.com/plataformatec/devise/wiki/How-To:-redirect-
  #         to-a-specific-page-on-successful-sign_in,-sign_out,-and-or-sign_up
  # How To: redirect to a specific page on successful sign_in, sign_out, and or
  #         sign_up
  # Miles Matthias edited this page on Jan 23, 2015
  #
  # You can override the default behaviour by creating an after_sign_in_path_for
  # [RDoc] method in your ApplicationController and have it return the path for
  # the page you want:
  #
  def after_sign_in_path_for(_resource_or_scope)
    topics_path # list of all public topics&bookmarks
  end

  # There exists a similar method for sign out; after_sign_out_path_for [RDoc]
  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path # login page
  end
end
