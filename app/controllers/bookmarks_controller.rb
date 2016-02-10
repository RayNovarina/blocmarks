#
class BookmarksController < ApplicationController
  # A frequent practice is to place the standard CRUD actions in each controller
  # in the following order:
  #   index, show, new, edit, create, update and destroy.
  #
  #
  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
    # Response: Controller will forward_to /views/bookmarks/new.html.erb
    #           with @bookmark
    # Note: clicking on the form submit button will POST to create()
  end

  # Note: we get here from a submit button via the new view.
  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params_whitelist)

    if @bookmark.save
      # Response: goto show parent topic, new bookmark, msgs.
      redirect_to @topic, notice: 'Bookmark was saved successfully.'
    else
      # Response: render new view with err msgs.
      flash.now[:alert] = 'Error creating bookmark. Please try again.'
      render :new
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    # Response: Controller will forward_to /views/bookmarks/edit.html.erb
    #           with @bookmark.
    # Note: clicking on the form submit button will POST to update()
  end

  # Note: we get here from a submit button via the edit view.
  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.assign_attributes(bookmark_params_whitelist)

    if @bookmark.save
      # Response: goto show parent topic, new bookmark, msgs.
      redirect_to @bookmark.topic, notice: 'Bookmark was updated'
    else
      # Response: render new view with err msgs.
      flash.now[:alert] = 'Error saving bookmark. Please try again.'
      render :edit
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy
      # Response: goto show parent topic, one less bookmark, msgs.
      redirect_to @bookmark.topic, notice:
        "\"#{@bookmark.title}\" was deleted successfully."
    else
      # Response: goto show parent topic and bookmarks, try again.
      redirect_to @bookmark.topic, alert:
        'There was an error deleting this bookmark.'
    end
  end

  private

  def bookmark_params_whitelist
    params.require(:bookmark).permit(:title, :description, :url)
  end
end
