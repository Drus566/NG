class MessagesController < ApplicationController

    include ActionView::Helpers::TagHelper
    
    before_action :logged_in_user

    def create
        @message = current_user.messages.build(message_params)
        @message.save

        if @message.errors.any? 
            render html: content_tag(:div, @message.errors.first.second, class: 'error'), status: 400
        end        
    end

      private  

        def message_params
            params.require(:message).permit(:body)
        end
end