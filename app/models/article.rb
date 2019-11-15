class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true, length: { maximum: 600 }
  validates :user_id, presence: true

  default_scope -> { order(created_at: :desc) }
end
