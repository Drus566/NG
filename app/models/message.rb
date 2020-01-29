class Message < ApplicationRecord

    after_save_commit { MessageBroadcastJob.perform_later(self) }

    belongs_to :user

    validates :body, presence: true, length: {minimum: 2, maximum: 200}

    def timestamp
        created_at.strftime('%H:%M:%S %d %B %Y')
    end
end
