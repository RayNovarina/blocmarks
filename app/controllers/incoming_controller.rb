#
class IncomingController < ApplicationController
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity
  #     -token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  #
  def create
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.
    # test locally:
    # http://localhost:3000/incoming/create?sender=support@wemeus.com&subject=dogs&body-plain=https://www.bloc.io
    puts "INCOMING PARAMS HERE: #{params}"

    user_email = params[:sender]
    puts "user_email = #{user_email}"
    @user = User.find_by_email(user_email)
    puts "@user = #{@user}"
    #
    topic = params[:subject]
    puts "topic = #{topic}"
    @topic = Topic.find_by_title(topic)
    puts "@topic = #{@topic}"
    #
    url = params['body-plain']
    puts "url = #{url}"

    if @user && @topic
      puts "Create a bookmark with a description of user_email: '#{user_email}'  subject: '#{topic}'  url: '#{url}'  Created bookmark for topic: '#{@topic.title}' for user: '#{@user.name}'"
      bookmark = Bookmark.create!(
        title: "topic is #{topic}",
        description: "user_email: '#{user_email}'  subject: '#{topic}'  url: '#{url}'  Created bookmark for topic: '#{@topic.title}' for user: '#{@user.name}'",
        url: url,
        topic: @topic
      )
      # Assuming all went well.
      head 200
    end

    # Test run results:
    # app[web.1]: Processing by IncomingController#create as */*
    # app[web.1]: user_email = rnova94037@gmail.com
    # @user =
    # app[web.1]: User Load (1.5ms)  SELECT  "users".* FROM "users"
    #   WHERE "users"."email" = $1 LIMIT 1  [["email", "rnova94037@gmail.com"]]
    # app[web.1]: topic = dogs
    # app[web.1]: @topic =
    # app[web.1]:   Topic Load (3.5ms)  SELECT  "topics".* FROM "topics"
    #   WHERE "topics"."title" = $1 LIMIT 1  [["title", "dogs"]]
    # app[web.1]: url = https://static.pexels.com/photos/7720/
    #                         night-animal-dog-pet.jpg
    #                   <https://static.pexels.com/photos/7720/
    #                         night-animal-dog-pet.jpg>
    # app[web.1]: Completed 200 OK in 34ms (ActiveRecord: 7.0ms)

    #-------------------------------
    # You put the message-splitting and business
    # magic here.

    # Find the user by using params[:sender]

    # Find the topic by using params[:subject]

    # Assign the url to a variable after retreiving it from params["body-plain"]

    # Check if user is nil, if so, create and save a new user

    # Check if the topic is nil, if so, create and save a new topic

    # Now that you're sure you have a valid user and topic, build and save a new
    # bookmark

    # Assuming all went well.
    # head 200
  end
end
