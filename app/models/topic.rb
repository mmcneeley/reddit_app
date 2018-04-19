class Topic < ApplicationRecord
has_many :posts


def self.search(search)
  Topic.where("name like ?", "%#{search}%")
end


end
