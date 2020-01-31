class ChatBroadcastJob < ApplicationJob
  queue_as :default
  
    def perform
        ActionCable.server.broadcast("chat_channel", { chat: render_message } )
    end

    private

        def render_message
            ChatController.render_chat
        end
end
