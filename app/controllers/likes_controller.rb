#
class LikesController < ApplicationController
  def index
    @likes = Like.all
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    if like.save
      redirect_to @bookmark, notice: 'success'
    else
      flash.now(:alert)
      redirect_to @bookmark
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    # Find the current user's like with the ID in the params

    if like.destroy
      # Flash success and redirect to @bookmark
    else
      # Flash error and redirect to @bookmark
    end
  end
end
