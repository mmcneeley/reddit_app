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
      @posts = Post.all.order(id: :desc)
      @posts
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
    #@users = User.all #i dont think we need this -mm
    @topics = Topic.all
  end

  def create
    @post = Post.create(post_params)
    if @post.valid?
      if working_url?(@post.url)
        add_scraped_tags
        get_image
        get_title
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
        if working_url?(@post.url)
          @post.tags.destroy_all
          add_scraped_tags
          get_image
          get_title
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
    tag_results = get_tags_name["keywords"]
    if tag_results != nil
      tags = tag_results[0].split(", ")
      tags.each do |tag|
        @tags = Tag.find_or_create_by(name: tag)
        @post.tags << @tags
      end
    end
  end

  def working_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
    rescue URI::InvalidURIError
    false
  end

  def get_title
    page = Nokogiri::HTML(open(@post.url))
    web_title = []
    web_title << page.css('title')[0].text
    title = web_title
    if title.first != nil
      @post.link_title = title.first
      @post.save
    end
  end

  def get_image
    page = MetaInspector.new(@post.url)
    image = page.images.best
    if image != nil
      @post.image_url = image
      @post.save
    end
  end

  def get_tags_name
    page = MetaInspector.new(@post.url)
    page.meta_tags['name']
  end

  def post_params
    # params.require(:post).permit(:title, :user_id, :url, :content, :search, :tags, :topic_id) - removing the :tags, and :search -mm
    params.require(:post).permit(:title, :user_id, :url, :content, :topic_id)
  end

  def get_post
    @post = Post.find(params[:id])
  end

  # def require_login
  #   return head(:forbidden) unless session.include? :user_id
  # end

end
