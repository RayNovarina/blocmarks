#
class UsersController < ApplicationController
  def show
    # populate @user_bookmarks with the user's bookmarks
    # @user_bookmarks = Bookmark.where(user_id: current_user.id).group(:topic_id)

    @topics_with_user_bookmarks =
      Topic.select('topics.*')
           .joins(:bookmarks)
           .where('bookmarks.user_id = ?', current_user.id)
           .reorder('lower(topics.title) ASC')
           .distinct('topics.id')

    # @user_bookmarks_for_first_topic =
    #  @topics_with_user_bookmarks[0].bookmarks = topic.bookmarks.where('bookmarks.user_id = ?', :current_user.id)
    # unless @topics_with_user_bookmarks.empty?


    # list chef whose recipes have the most up votes first.
    #  Chef.all
    #      .joins(recipes: :likes).where("likes.like = ?", "t")
    #      .select("chefs.*, count(likes.like) as num_votes").group("chefs.id")
    #      .reorder("num_votes DESC").order("chefs.name ASC")
    #      .paginate(page: url_params[:page], per_page: 3)
    #
    # populate @liked_bookmarks with liked bookmarks
    # @liked_bookmarks = Bookmark.joins(:likes).where('likes.user_id = ?', current_user.id).group(:topic_id)

    @topics_with_user_liked_bookmarks =
      Topic.select('topics.*')
           .joins(bookmarks: :likes)
           .where('likes.user_id = ?', current_user.id)
           .reorder('lower(topics.title) ASC')
           .distinct('topics.id')

    # @liked_bookmarks_for_first_topic =
    #  @topics_with_user_liked_bookmarks[0].bookmarks.where('bookmarks.user_id = ?', :current_user.id)
    # unless @topics_with_user_liked_bookmarks.empty?

  end
end
