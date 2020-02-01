class ChatBroadcastJob < ApplicationJob
  queue_as :default
  
    def perform
        ActionCable.server.broadcast("chat_channel", { chat: render_message } )
    end

    private

        def render_message
            @message = Message.new
            @messages = Message.all
            MessagesController.render partial: 'messages/chat', locals: { message: @message, messages: @messages }
        end
end
