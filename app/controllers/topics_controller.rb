class TopicsController < ApplicationController
before_action :get_topic, only:[:show]

  def index
    @topics = Topic.all
  end

  def new
  end

  def create
  end

  def show
  end


  private

  def topic_params
    params.require(:topic).permit(:name)
  end

  def get_topic
    @topic = Topic.find(params[:id])
  end


end
