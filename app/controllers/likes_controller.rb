#
class LikesController < ApplicationController
  def index
    authorize Like
    @likes = Like.all
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)
    authorize like

    if like.save
      # Response: Redisplay bookmark view with new like state, msgs.
      redirect_to :back, notice: 'Bookmark was Liked successfully.'
    else
      # Response: Redisplay bookmarks view with err msgs.
      redirect_to :back, alert: 'Error creating like. Please try again.'
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    # Find the current user's like with the ID in the params
    like = Like.find(params[:id])
    authorize like

    if like.destroy
      # Response: Redisplay bookmark view with new like state, msgs.
      redirect_to :back, notice: 'Bookmark was UnLiked successfully.'
    else
      # Response: Redisplay bookmarks view with err msgs.
      redirect_to :back, alert: 'Error destroying like. Please try again.'
    end
  end
end
