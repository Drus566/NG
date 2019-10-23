class Article < ApplicationRecord
  belongs_to :user
  validates :title, length: { maximum: 100 }

  default_scope -> { order(created_at: :desc) }
end
