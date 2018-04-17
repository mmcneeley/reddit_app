class PostsController < ApplicationController

before_action :get_post, only:[:show, :edit, :update, :destroy]
before_action :require_login
skip_before_action :require_login, only:[:new, :create]

  def index
    @posts = Post.all
  end

  def show
    #list all the comments
    @comments = @post.comments
    #this is for the commenting to get a random user, until we have auth
    @user_sample = User.all.sample
  end

  def new
    @post = Post.new
    @users = User.all
  end

  def create
    @post = Post.create(post_params)
    if @post.valid?
      flash[:success] = "you created a post!"
      redirect_to @post
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def edit
    @users = User.all
  end

  def update
    @post.update(post_params)
    redirect_to @post
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :user_id, :url)
  end

  def get_post
    @post = Post.find(params[:id])
  end

  def require_login
    return head(:forbidden) unless session.include? :user_id
  end

end
