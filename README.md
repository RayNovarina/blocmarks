Blocmarks

Intro

Build an application that allows a user to bookmark URLs via email, peruse other user's bookmarks and maintain a personal index of categorized bookmarks.
Use Case

It's easy enough to bookmark a URL in your browser, but eventually your bookmark library may get cluttered and it may require effort to manage bookmarks. Wouldn't you also like the ability to share bookmarks with friends? That is not something you can do easily from your native browser.

Blocmarks will solve these problems by organizing bookmarks by topic and making them public so that other users can find them and add bookmarks to their own Blocmarks profile.

User Stories

As a user, I want to sign up for a free account by providing a user name, password and email 	2
  Devise tutorial: http://www.sitepoint.com/devise-authentication-in-depth/
  A new folder called devise will be created inside the views directory. Folders that are inside:

    confirmations – This has a lone new.html.erb view that is being rendered when a user requests to resend the confirmation e-mail.
    mailer – All the templates for emails are stored here.
    passwords – Views with forms to request password, reset email, and actually change the password.
    registrations – The new.html.erb view is rendered when a user registers on the site. edit.html.erb contains a form to update profile.
    sessions – There is only one view, which is the login form for the site.
    shared – Only one partial is present here, which contains links that are being displayed on each Devise’ page (like “Forgot your password?”, “Re-send confirmation email”, etc.)
    unlocks – Only one view with a form to request an email with an unlock link.

As a user, I want to sign in and out of Blocmarks 	2
As a user, I want to email a URL to Blocmarks and have it saved in the Blocmarks database 	3
As a user, I want to see an index of all topics and their bookmarks 	3
As a user, I want to create, read, update, and delete bookmarks 	2
As a user, I want to be the only one allowed to delete and update my bookmarks 	3
As a user, I want to "like and unlike" bookmarks created by other users 	2
As a user, I want to see a list of bookmarks on my personal profile that I've added or liked 	3

Before you begin working on user stories, complete this project's Getting Started guide. Later user stories often rely on the completion of the former, therefore, work on them in the order prescribed.
Wireframes

These wireframes are meant to suggest a design, not dictate one.
Wireframe 	Description

===================
<!DOCTYPE html>
<html>
<head>
  <!-- ==== Begin: HTML HEAD TAG === -->
  <meta charset="utf-8">
  <title>Blocmarks</title>
  <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
  <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  <%= csrf_meta_tags %>
  <!-- ==== End: HTML HEAD TAG === -->
</head>
<body>

<% # ===== Blocmarks Page LAYOUT: ====   %>
<% # Note: default/global content can be override via content_for/yeild hooks %>
<% #------------------------------------------------------- %>
<% # Section0: (CSS: doc#header) -Global- %>
   <% # <header> Page Header  %>
     <% # <nav> Page Header navigation  %>
<% #------------------------------------------------------- %>
<% # Section1: (CSS: doc#main) -Global- %>
   <% # <main> Page Content  %>
    <% #---------------------------------- %>
    <% # <header> Page Main Content Header  %>
      <% # <section> Page Main Content messages -Global-  %>
    <% #---------------------------------- %>
    <% # <main> Page Main Content Body -Global- %>
      <% # <header> Page Main Content Body Header -Optional-  %>
        <% # <nav> Page Main Content navigation  %>
      <% # <main> Page Main Content Body -Optional- %>
      <% # <footer> Page Main Content Footer -Optional- %>
        <% # <nav> Page Main Content navigation  %>
    <% #---------------------------------- %>
    <% # <footer> Page Main Content Footer -Optional- %>
      <% # <nav> Page Main Content navigation  %>
<% #------------------------------------------------------- %>
<% # Section2: (CSS: doc#footer) Global %>
  <% # <footer> Page Footer %>
    <% # <nav> Page Footer navigation  %>


<!-- # ======== Begin: PAGE HEADER -global- ========== -->
<header>
  <!-- # == Begin: Page Header Navigation - Navbar, inverse == -->
  <nav class="navbar navbar-inverse">
  <div class="container">
    <% if content_for?(:override_page_header_navbar) %>
      <!-- # == Begin: Page Header Navbar override == -->
      <%= yield :override_page_header_navbar %>
      <!-- # == End: Page Header Navbar override == -->
    <% else %>
      <div class="navbar-header">
        <%= link_to 'Blockmarks', root_path, class: 'navbar-brand' %>
      </div>
      <div id="navbar">
        <ul class="nav navbar-nav">
          <li><%= link_to 'Home', root_path %></li>
        </ul>
        <ul class="nav navbar-nav pull-right">
          <li><%= link_to 'Log In', new_user_session_path %></li>
          <li><%= link_to 'Sign Up', new_user_registration_path %></li>
        </ul>
      </div>
    <% end %>
  </div>
  </nav>
  <!-- # ======== End: Page Header Navigation == -->
</header>
<!-- # ======== End: PAGE HEADER -global- ========== -->

<% #------------------------------------------------------- %>
<% # Section1: (CSS: doc#main) -Global- %>
    <% #---------------------------------- %>
    <% # <main> Page Main Content Body -Global- %>
      <% # <header> Page Main Content Body Header -Optional-  %>
        <% # <nav> Page Main Content navigation  %>
      <% # <main> Page Main Content Body -Optional- %>
      <% # <footer> Page Main Content Footer -Optional- %>
        <% # <nav> Page Main Content navigation  %>
    <% #---------------------------------- %>
    <% # <footer> Page Main Content Footer -Optional- %>
      <% # <nav> Page Main Content navigation  %>
<% #------------------------------------------------------- %>

<!-- # ======= Begin: PAGE MAIN -global- ===== -->
<main>
  <!-- # == Begin: PAGE MAIN HEADER -->
  <header>
    <!-- # == Begin: PAGE MAIN HEADER messages -->
    <section>
    <div class="container">
      <div class="flash">
        <% if flash[:notice] %>
         <div class="alert alert-success">
          <button type="button" class="close" data-dismiss="alert">&times</button>
          <%= flash[:notice] %>
        </div>
      <% elsif flash.now[:alert] %>
        <div class="alert alert-danger">
          <button type="button" class="close" data-dismiss="alert">&times</button>
          <%= flash.now[:alert] %>
        </div>
      <% elsif flash[:alert] %>
        <div class="alert alert-success">
          <button type="button" class="close" data-dismiss="alert">&times</button>
          <%= flash[:alert] %>
        </div>
      <% end %>
    </div>
    </div>
  </section>
    <!-- # == End: PAGE MAIN HEADER messages -->
  </header>
  <!-- # ======== End: PAGE MAIN HEADER ========== -->


  <!--  # == Begin: BODY main container - Jumbotron == -->
  <div class="jumbotron">

  <!--  # == Begin: BODY - yield :page_top content. Optional, depends on how page is rendered. == -->
    <%= yield :page_top_content %>
  <!--  # == End: BODY - yield :page_top_content. == -->

  <!--  # == Begin: BODY main container. == -->
  <div class="container">

  <!--  # == Begin: Main - yield :page_header. == -->
  <h1><%= yield :page_header %></h1>
  <!--  # == End: Main - yield :page_header. == -->

  <!--  # == Begin: Main - yield == -->
  <%= yield %>
  <!--  # == End: Main - yield == -->
  </div>
  <!--  # == End: BODY main container. == -->

  </div>
  <!-- # == End: BODY main container - Jumbotron == -->

</main>
<!-- # == End: PAGE MAIN -global- == -->

<!--  # ======== Begin: PAGE FOOTER -global- ========== -->
<footer>
  <header>
    <hr>
  </header>
  <nav>
    <div class="container">
      <p class="text-muted">Created by <a href="https://cdn-photos.bloc.io/medium/2317655/photo.JPG?1450380571" target="_blank">A student at Block.io</a></p>
    </div>
  </nav>
</footer>
<!-- # ======== End: PAGE FOOTER - global ========== -->

</body>
</html>

=============================
<!DOCTYPE html>
<html>
<head>
  <!-- ==== Begin: HTML HEAD TAG === -->
  <meta charset="utf-8">
  <title>Blocmarks</title>
  <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
  <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  <%= csrf_meta_tags %>
  <!-- ==== End: HTML HEAD TAG === -->
</head>
<body>

<% # ===== Blocmarks Page LAYOUT: ====   %>
<% # Note: default/global content can be override via content_for/yeild hooks %>
<% #------------------------------------------------------- %>
<% # Section0: (CSS: doc#header) -Global- %>
   <% # <header> Page Header  %>
     <% # <nav> Page Header navigation  %>
<% #------------------------------------------------------- %>
<% # Section1: (CSS: doc#main) -Global- %>
   <% # <main> Page Content  %>
    <% #---------------------------------- %>
    <% # <header> Page Main Content Header  %>
      <% # <section> Page Main Content messages -Global-  %>
    <% #---------------------------------- %>
    <% # <main> Page Main Content Body -Global- %>
      <% # <header> Page Main Content Body Header -Optional-  %>
        <% # <nav> Page Main Content navigation  %>
      <% # <main> Page Main Content Body -Optional- %>
      <% # <footer> Page Main Content Footer -Optional- %>
        <% # <nav> Page Main Content navigation  %>
    <% #---------------------------------- %>
    <% # <footer> Page Main Content Footer -Optional- %>
      <% # <nav> Page Main Content navigation  %>
<% #------------------------------------------------------- %>
<% # Section2: (CSS: doc#footer) Global %>
  <% # <footer> Page Footer %>
    <% # <nav> Page Footer navigation  %>


<!-- # ======== Begin: PAGE HEADER -global- ========== -->
<header>
  <!-- # == Begin: Page Header Navigation - Navbar, inverse == -->
  <nav class="navbar navbar-inverse">
  <div class="container">
    <% if content_for?(:override_page_header_navbar) %>
      <!-- # == Begin: Page Header Navbar override == -->
      <%= yield :override_page_header_navbar %>
      <!-- # == End: Page Header Navbar override == -->
    <% else %>
      <div class="navbar-header">
        <%= link_to 'Blockmarks', root_path, class: 'navbar-brand' %>
      </div>
      <div id="navbar">
        <ul class="nav navbar-nav">
          <li><%= link_to 'Home', root_path %></li>
        </ul>
        <ul class="nav navbar-nav pull-right">
          <li><%= link_to 'Log In', new_user_session_path %></li>
          <li><%= link_to 'Sign Up', new_user_registration_path %></li>
        </ul>
      </div>
    <% end %>
  </div>
  </nav>
  <!-- # ======== End: Page Header Navigation == -->
</header>
<!-- # ======== End: PAGE HEADER -global- ========== -->

<% #------------------------------------------------------- %>
<% # Section1: (CSS: doc#main) -Global- %>

    <% #---------------------------------- %>
    <% # <main> Page Main Content Body -Global- %>

      <% # <header> Page Main Content Body Header -Optional-  %>
        <% # <nav> Page Main Content Body Header navigation  %>
      <% # <main> Page Main Content Body Body -Optional- %>
      <% # <footer> Page Main Content Body Footer -Optional- %>
        <% # <nav> Page Main Content Body Footer navigation  %>

    <% #---------------------------------- %>
    <% # <footer> Page Main Content Body Footer -Optional- %>
      <% # <nav> Page Main Content Body Footer navigation  %>
<% #------------------------------------------------------- %>

<!-- # ======= Begin: PAGE MAIN -global- ===== -->
<main>
  <!-- # == Begin: PAGE MAIN HEADER -global- -->
  <header>
    <!-- # == Begin: PAGE MAIN HEADER messages -optional- -->
    <section>
    <div class="container">
      <div class="flash">
        <% if flash[:notice] %>
         <div class="alert alert-success">
          <button type="button" class="close" data-dismiss="alert">&times</button>
          <%= flash[:notice] %>
        </div>
      <% elsif flash.now[:alert] %>
        <div class="alert alert-danger">
          <button type="button" class="close" data-dismiss="alert">&times</button>
          <%= flash.now[:alert] %>
        </div>
      <% elsif flash[:alert] %>
        <div class="alert alert-success">
          <button type="button" class="close" data-dismiss="alert">&times</button>
          <%= flash[:alert] %>
        </div>
      <% end %>
    </div>
    </div>
  </section>
  <!-- # == End: PAGE MAIN HEADER messages -optional- -->
  </header>
  <!-- # == End: PAGE MAIN HEADER -global- -->

  <!-- # == Begin: Page Main Content Body -Global- -->
  <main>

    <header>
      <nav>
      </nav>
    </header>

    <main>
        <!--  # == Begin: BODY main container - Jumbotron == -->
        <div class="jumbotron">
        <!--  # == Begin: BODY - yield :page_top content. Optional, depends on how page is rendered. == -->
        <%= yield :page_top_content %>
        <!--  # == End: BODY - yield :page_top_content. == -->
        <!--  # == Begin: BODY main container. == -->
        <div class="container">
        <!--  # == Begin: Main - yield :page_header. == -->
        <h1><%= yield :page_header %></h1>
        <!--  # == End: Main - yield :page_header. == -->
        <!--  # == Begin: Main - yield == -->
        <%= yield %>
        <!--  # == End: Main - yield == -->
        </div>
        <!--  # == End: BODY main container. == -->
        </div>
        <!-- # == End: BODY main container - Jumbotron == -->
    </main>

    <footer>
    </footer>

  </main>

  <footer>
  </footer>

</main>
<!-- # == End: PAGE MAIN -global- == -->

<!--  # ======== Begin: PAGE FOOTER -global- ========== -->
<footer>
  <header>
    <hr>
  </header>
  <nav>
    <div class="container">
      <p class="text-muted">Created by <a href="https://cdn-photos.bloc.io/medium/2317655/photo.JPG?1450380571" target="_blank">A student at Block.io</a></p>
    </div>
  </nav>
</footer>
<!-- # ======== End: PAGE FOOTER - global ========== -->

</body>
</html>
