class Tag < ApplicationRecord
has_many :post_tags, dependent: :destroy
has_many :posts, through: :post_tags, dependent: :destroy

def self.search(search)
  t = Post.where("tags like ?", "%#{search}%")
end

end
