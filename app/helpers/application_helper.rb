#
module ApplicationHelper
  # For HTML header tag in the views.
  #   Example:  /views/devise/registrations/new.html.erb
  #     <% page_header "Sign Up" %>
  #     Gets inserted into the .erb page via /views/layouts/application.html.erb
  #       <h1><%= yield :page_header %></h1>
  def page_title(text)
    content_for(:page_title) { text.to_s }
  end

  def page_main(text)
    content_for(:page_main_body_content_at_last) { text.to_s }
  end

  def page_main_body_content_at_last(text)
    content_for(:page_main_body_content_at_last) { text.to_s }
  end
end
