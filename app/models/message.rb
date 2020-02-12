class Message < ApplicationRecord

    after_save_commit { MessageBroadcastJob.perform_later(self) }

    belongs_to :user

    validate :body_presence
    validate :body_length

    def timestamp
        created_at.strftime('%H:%M:%S %d %B %Y')
    end

    private 

        def body_presence  
            errors.add(:body, 'Сообщение чата пустое') if ActionView::Base.full_sanitizer.sanitize(body).blank?
        end

        def body_length 
            @max_length = 255
            errors.add(:body, 'Сообщение чата длиннее 255 символов') if ActionView::Base.full_sanitizer.sanitize(body).size > @max_length
        end
end
