class PostsController < ApplicationController

  before_action :get_post, only:[:show, :edit, :update, :destroy]
  #before_action :require_login
  #skip_before_action :require_login, only:[:new, :create]
  before_action :authorized?, only: [:create, :update, :destroy]

  def index
    # @posts = Post.where(["tags like ?","%#{params[:search]}%"])
    if params[:search]
      @posts = Post.search(params[:search])
    else
      @posts = Post.all
    end
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
    @topics = Topic.all
  end

  def create
    @post = Post.create(post_params)
    if @post.valid?
      if @post.url.length > 0
       add_scraped_tags
      end
      flash[:success] = "you created a post!"
      redirect_to @post
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end

  def edit
    @topics = Topic.all
    @users = User.all
  end

  def update
    @post.update(post_params)
    if @post.valid?
        if @post.url
          add_scraped_tags
        end
      redirect_to @post
      flash[:success] = "you edited a post!"
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to edit_post_path
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def add_scraped_tags
    keywords = get_tags_name["keywords"][0].split(", ")
    keywords.each do |keyword|
    @tags = Tag.find_or_create_by(name: keyword)
    @post.tags << @tags
    end
  end

  def post_params
    params.require(:post).permit(:title, :user_id, :url, :content, :search, :tags, :topic_id)
  end

  def get_post
    @post = Post.find(params[:id])
  end

  # def require_login
  #   return head(:forbidden) unless session.include? :user_id
  # end

end
