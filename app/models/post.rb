class Post < ApplicationRecord
require 'obscenity/active_model'

  belongs_to :user
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :title, presence: true
  # validates :url, url: { allow_blank: true }
  validates :title,  obscenity: { sanitize: true, replacement: "@!#%"}
  validates :content,  obscenity: { sanitize: true, replacement: "@!#%"}

  def self.search(search)
    p = Post.all
    a = []
    p.each do |post|
      post.tags.each do |tag|
        if tag.name.downcase == search.downcase
          a << post
        end
      end
    end
    a
  end

  def score
    self.votes.sum(:value)
  end

end
