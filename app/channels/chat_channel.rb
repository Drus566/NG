class ChatChannel < ApplicationCable::Channel

    def subscribed
        stream_from 'chat_channel'
        ChatBroadcastJob.perform_later
    end

    def unsubscribed
        stop_all_streams
    end

    # def speak(data)
    #     # ActionCable.server.broadcast 'chat_channel', message: data['message']
    #     # current_user.messages.create!(body: data['message'])
    # end
end
