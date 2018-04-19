class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  validates :title, presence: true
  # validates :url, url: { allow_blank: true }

  def self.search(search)
  
  end

  # def self.search(search)
  #   t = Tag.where("name like ?", "%#{search}%")
  # end


  def score
    self.votes.sum(:value)
  end

end
