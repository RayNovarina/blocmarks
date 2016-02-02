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
