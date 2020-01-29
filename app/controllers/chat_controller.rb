class ChatController < ApplicationController

    def show
        @messages = Message.all
        @message = Message.new
        render template: 'chat/show', layout: false
    end
end
