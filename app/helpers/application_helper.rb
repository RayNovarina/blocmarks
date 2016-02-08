#
# Methods in this file are normally only available to views.
#
module ApplicationHelper
  #
  #===========================
  #         for VIEWS
  #===========================
  #
  def return_view_hash_of(url_params, action_hash)
    action_hash[:params] = url_params
    action_hash[:controller] = url_params[:controller]
    action_hash[:action] = url_params[:action]
    action_hash[:page_name] =
      "#{action_hash[:controller]}-#{action_hash[:action]}"
    action_hash
  end
  #
  # For HTML header tag in the views.
  #   Example:  /views/devise/registrations/new.html.erb
  #     <% page_header "Sign Up" %>
  #     Gets inserted into the .erb page via /views/layouts/application.html.erb
  #       <h1><%= yield :page_header %></h1>

  def page_title(text)
    content_for(:page_title) { text.to_s }
  end

  def override_page_footer_nav(text)
    content_for(:override_page_footer_nav) { text.to_s }
  end

  def override_page_header_navbar(text)
    content_for(:override_page_header_navbar) { text.to_s }
  end

  def page_main_header_other_messages(text)
    content_for(:page_main_header_other_messages) { text.to_s }
  end

  def page_main_footer(text)
    content_for(:page_main_footer) { text.to_s }
  end
end
