class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags
  validates :title, presence: true
  validate :foul_words
  # validates :url, url: { allow_blank: true }

def self.search(search)

end

def foul_words
  bad_words = ["shit","fuck","ass","fucker","motherfucker","bitch", "slut", "fag", "pussy", "dick"]
  bad_words.each do |word|
    if title.downcase.include?(word) || content.downcase.include?(word)
    errors.add(:foul_words,"- Wash your hands out with soap, that language ain't tolerated on Wroteit!")
    end
  end
end


  def score
    self.votes.sum(:value)
  end

end
