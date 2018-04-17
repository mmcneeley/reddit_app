class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :web_scraper, :get_title, :get_image, :working_url?
  require 'nokogiri'
  require 'open-uri'
  require 'metainspector'
  require 'net/http'

  def working_url?(url)
   url = URI.parse(url) rescue false
   url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
 end

  def web_scraper
    Nokogiri::HTML(open(url))
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

end
