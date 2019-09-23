class Like < ApplicationRecord
    belongs_to :user
    belongs_to :likeable, polymorphic: true

    validates :vote, exclusion: { in: [nil] }
    validates :user_id, presence: true
end
