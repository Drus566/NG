class Post < ApplicationRecord
    belongs_to :user
    belongs_to :section, optional: true
    has_many :comments, -> {order(created_at: :asc)}, as: :commentable, dependent: :destroy
    has_many :likes, -> {order(created_at: :asc)}, as: :likeable, dependent: :destroy

    has_rich_text :content

    default_scope -> { order(created_at: :desc) }

    validates :user_id, presence: true

    def get_like(current_user)
        self.likes.find_by(user_id: current_user)
    end

    def like?(current_user, vote)
        self.likes.find_by(user_id: current_user, vote: vote) != nil
    end

    def count_likes
        self.likes.where(vote: true).count - self.likes.where(vote: false).count
    end
end