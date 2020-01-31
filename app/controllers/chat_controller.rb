class ChatController < ApplicationController

    def self.render_chat  
        @messages = Message.all
        @message = Message.new
        render template: 'chat/show', layout: false
    end
end
