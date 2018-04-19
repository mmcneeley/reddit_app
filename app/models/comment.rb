class Comment < ApplicationRecord
require 'obscenity/active_model'
  belongs_to :post
  belongs_to :user
  validates :content,  obscenity: { sanitize: true, replacement: "@!#%"}
end
