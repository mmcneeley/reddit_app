class Vote < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: :post_id, message: "You can only vote one time"}
  validates :value, inclusion: { in: [1,-1], message: "Must be an up or down vote"}

end
