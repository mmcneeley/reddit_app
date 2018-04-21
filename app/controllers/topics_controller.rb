class TopicsController < ApplicationController
before_action :get_topic, only:[:show]

  def index
    if params[:search]
      @topics = Topic.search(params[:search])
    else
      @topics = Topic.all
    end
  end

  def new
  end

  def create
  end

  def show
    @posts = @topic.posts
  end


  private

  def topic_params
   params.require(:topic).permit(:name, :search)
  end

  def get_topic
    @topic = Topic.find(params[:id])
  end

end
