#
class TopicsController < ApplicationController
  # A frequent practice is to place the standard CRUD actions in each controller
  # in the following order:
  #   index, show, new, edit, create, update and destroy.
  #
  def index
    @topics = Topic.all
    # Response: Controller will forward_to /views/topics/index.html.erb
    #           with @topics
  end

  def show
    @topic = Topic.find(params[:id])
    # Response: Controller will forward_to /views/topics/show.html.erb
    #           with @topic
  end

  def new
    @topic = Topic.new
    # Response: Controller will forward_to /views/topics/new.html.erb
    #           with @topic
    # Note: clicking on the form submit button will POST to create()
  end

  # Note: we get here from a submit button via the new view.
  def create
    @topic = Topic.new(topic_params_whitelist)
    @topic.user = current_user

    # Response: redirect to or forward_to a view with msgs.
    if @topic.save
      redirect_to @topic, notice: 'Topic was saved successfully.'
    else
      flash.now[:alert] = 'Error creating topic. Please try again.'
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
    # Response: Controller will forward_to /views/topics/edit.html.erb
    #           with @view hash of results.
    # Note: clicking on the form submit button will POST to update()
  end

  # Note: we get here from a submit button via the edit view.
  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params_whitelist)

    # Response: redirect to or forward_to a view with msgs
    if @topic.save
      flash[:notice] = 'Topic was updated'
      redirect_to @topic
    else
      flash.now[:alert] = 'Error saving topic. Please try again.'
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    # Response: redirect to or forward_to to a view.
    if @topic.destroy
      flash[:notice] = "\"#{@topic.title}\" was deleted successfully."
      redirect_to @topic
    else
      flash.now[:alert] = 'There was an error deleting the topic.'
      render :show
    end
  end

  private

  def topic_params_whitelist
    params.require(:topic).permit(:title, :description)
  end
end
