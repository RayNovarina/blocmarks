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

    # populate @liked_bookmarks with liked bookmarks
    # @liked_bookmarks = Bookmark.joins(:likes).where('likes.user_id = ?', current_user.id).group(:topic_id)
    @topics_with_user_liked_bookmarks =
      Topic.select('topics.*')
           .joins(bookmarks: :likes)
           .where('likes.user_id = ?', current_user.id)
           .reorder('lower(topics.title) ASC')
           .distinct('topics.id')
  end
end
