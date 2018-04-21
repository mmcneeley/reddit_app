class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates_uniqueness_of :username, :case_sensitive => false
  #validates :email, presence: false, uniqueness: true
end
