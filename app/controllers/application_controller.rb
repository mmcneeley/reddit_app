class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  require 'nokogiri'
  require 'uri'
  require 'open-uri'
  require 'metainspector'
  require 'net/http'
  require "validate_url"
  helper_method :get_title, :get_image, :working_url?, :get_tags_name
  helper_method :logged_in?
  helper_method :current_user
  #helper_method :authorized?

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
    web_title
  end

  def get_image
    page = MetaInspector.new(@post.url)
    page.images.best
  end

  def get_tags_name
    page = MetaInspector.new(@post.url)
    page.meta_tags['name']
  end

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized?
    #redirect_to login_path unless current_user
    redirect_to login_path unless logged_in?
  end

end
