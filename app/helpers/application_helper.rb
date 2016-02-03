#
module ApplicationHelper
  # For HTML header tag in the views.
  #   Example:  /views/devise/registrations/new.html.erb
  #     <% page_header "Sign Up" %>
  #     Gets inserted into the .erb page via /views/layouts/application.html.erb
  #       <h1><%= yield :page_header %></h1>
  def page_header(text)
    content_for(:page_header) { text.to_s }
  end
end
