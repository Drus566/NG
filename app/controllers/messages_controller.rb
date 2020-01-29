class MessagesController < ApplicationController

    def new
        @message = Message.new
    end  

    def create
        @message = current_user.messages.build(message_params)
        @message.save
    end

      private  

        def message_params
            params.require(:message).permit(:body)
        end
end