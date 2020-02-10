class Message < ApplicationRecord

    after_save_commit { MessageBroadcastJob.perform_later(self) }

    belongs_to :user

    validates :body, presence: { message: 'Сообщение не может быть пустым' }, length: {minimum: 2, maximum: 200, message: 'Сообщение должно быть длинной от 2 до 200 символов'}

    def timestamp
        created_at.strftime('%H:%M:%S %d %B %Y')
    end
end
