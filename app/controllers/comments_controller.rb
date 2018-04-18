class CommentsController < ApplicationController

  before_action :authorized?, only: [:create, :update, :destroy]

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  def new
  end

  def show
  end

  def create
    #create off the params from the posts/:id/ #show
    @comment = Comment.create(
      content: params[:content],
      user_id: params[:user_id],
      post_id: params[:post_id]
    )
    #send back to the post
    redirect_to post_path(@comment.post)
  end

  def update
  end

  def destroy
    @comment = Comment.find(params[:post_id])
    @comment.destroy
    redirect_to post_path(@comment.post)
  end

  private
  #no private methods for now

end
