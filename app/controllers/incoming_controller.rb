#
class IncomingController < ApplicationController
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity
  #     -token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  # user_email = params[:sender]
  # @user = User.find_by_email(user_email)
  # topic = params[:subject]
  # @topic = Topic.find_by_title(topic)
  # url = params['body-plain']
  # Check if user is nil, if so, create and save a new user
  # Check if the topic is nil, if so, create and save a new topic
  # Now if you have a valid user and topic, build and save a new bookmark
  #
  def create
    #
    user = get_user_by_email_or_create
    if user && user.errors.messages.empty?
      topic = get_topic_by_title_or_create(user)
    else
      topic = nil
    end
    if topic && topic.errors.messages.empty?
      bookmark = create_bookmark(topic)
    else
      bookmark = nil
    end
    if bookmark && bookmark.errors.messages.empty?
      topic.bookmarks << bookmark
      topic.save
    end
    # Assuming all went well.
    # Else user, topic, bookmark may be nil or have .errors{}
    head 200
  end

  private

  def get_user_by_email_or_create
    user = User.find_by_email(params[:sender]) || create_new_user
    user
  end

  def create_new_user
    user = User.new(user_incoming_params_whitelist)
    user.save
    user
  end

  def user_incoming_params_whitelist
    params[:user] = {
      name: 'Created by email submission',
      password: 'password'
    }
    params[:user][:email] = params[:sender] if params.key?(:sender)
    params.require(:user).permit(:email, :password, :name)
  end

  def get_topic_by_title_or_create(user)
    topic = Topic.find_by_title(params[:subject]) || create_new_topic(user)
    topic
  end

  def create_new_topic(user)
    topic = Topic.new(topic_incoming_params_whitelist)
    topic.user = user
    topic.save
    topic
  end

  def topic_incoming_params_whitelist
    params[:topic] = {
      description: 'Created by email submission'
    }
    params[:topic][:title] = params[:subject] if params.key?(:subject)
    params.require(:topic).permit(:title, :description)
  end

  def create_bookmark(topic)
    bookmark = topic.bookmarks.build(bookmark_incoming_params_whitelist)
    bookmark.save
    bookmark
  end

  def bookmark_incoming_params_whitelist
    params[:bookmark] = {
      title:       'Created by email submission',
      description: 'Please complete: Created by email submission'
    }
    params[:bookmark][:url] = params['body-plain'] if params.key?('body-plain')
    params.require(:bookmark).permit(:title, :description, :url)
  end
  #
end
