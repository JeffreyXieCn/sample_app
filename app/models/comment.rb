class Comment < ApplicationRecord
  belongs_to :micropost  #a comment is a specific user made on a specific micropost, and a user can give multiple comments on the same micropost
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: {maximum: 140}
end
