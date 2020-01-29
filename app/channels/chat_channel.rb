class ChatChannel < ApplicationCable::Channel

    def subscribed
        stream_from 'chat_channel'
    end

    def unsubscribed
      
    end

    def speak(data)
        # ActionCable.server.broadcast 'chat_channel', message: data['message']
        # current_user.messages.create!(body: data['message'])
    end
end
