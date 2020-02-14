class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :commentable, polymorphic: true
    belongs_to :parent, class_name: 'Comment', optional: true
    has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

    default_scope -> { order(created_at: :desc) }

    validate :content_presence
    validate :content_length

    private 

        def content_presence  
            errors.add(:content, 'Комментарий пуст') if ActionView::Base.full_sanitizer.sanitize(content).blank?
        end

        def content_length 
            @max_length = 250
            errors.add(:content, 'Комментарий длиннее 250 символов') if ActionView::Base.full_sanitizer.sanitize(content).size > @max_length
        end
end
