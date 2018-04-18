class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :url, url: { allow_blank: true }

  def self.search(search)
    if search
      tag = Post.find_by(tags: search)
        if tag
          self.where(tags: tag)
        else
          Post.all
        end
      else
        Post.all
    end
  end

end
