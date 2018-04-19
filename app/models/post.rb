class Post < ApplicationRecord
require 'obscenity/active_model'
  belongs_to :user
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags
  validates :title, presence: true
  # validates :url, url: { allow_blank: true }
  validates :title,  obscenity: { sanitize: true, replacement: "@!#%"}
  validates :content,  obscenity: { sanitize: true, replacement: "@!#%"}
def self.search(search)

end






  def score
    self.votes.sum(:value)
  end

end
