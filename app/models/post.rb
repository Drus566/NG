class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments, -> {order(created_at: :asc)}, as: :commentable, dependent: :destroy
  has_many :likes, -> {order(created_at: :asc)}, as: :likeable, dependent: :destroy
  
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 600 }
end
