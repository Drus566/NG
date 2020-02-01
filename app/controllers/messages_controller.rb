class MessagesController < ApplicationController

    # def new
    #     @message = Message.new
    # end  

    def create
        @message = current_user.messages.build(message_params)
        @message.save
    end

    # def show
    #     @messages = Message.all
    #     @message = Message.new
    #     render template: 'chat/show', layout: false
    # end

    def self.get_chat
        @messages = Message.all
        @message = Message.new
        render partial: 'messages/chat', layout: false
    end

      private  

        def message_params
            params.require(:message).permit(:body)
        end
end