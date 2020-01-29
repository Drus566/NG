class MessageBroadcastJob < ApplicationJob
    queue_as :default
  
    def perform(message)
        ActionCable.server.broadcast "chat_channel", render_message(message)
    end

    private

        def render_message(message)
            MessagesController.render partial: 'messages/message', locals: { message: message }, layout: false
        end
  end