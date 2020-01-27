class LikesController < ApplicationController
    
    before_action :set_likeable
    before_action :set_like, only: [:update, :destroy]

    def create
        @like = @likeable.likes.new(like_params)
        @like.user = current_user
        if @like.save 
            render layout: false
        end
    end

    def update 
        if @like.update(like_params)
            render layout: false
        end
    end

    def destroy
        if @like.errors.empty?
            @like.destroy 
            render layout: false
        end
    end

    private 

        def set_likeable
            resource, id = request.path.split('/')[1,2]
            @likeable = resource.singularize.classify.constantize.find(id)
        end

        def set_like
            begin
                @like = @likeable.likes.find(params[:id])
            rescue => e
                logger.error "#{e.class.name} : #{e.message}"
                @like = @likeable.likes.build
                @like.errors.add(:base, :recordnotfound, message: "That record doesn't exist. Maybe, it is already destroyed")
            end
        end

        def like_params
            params.require(:like).permit(:vote)
        end
end
