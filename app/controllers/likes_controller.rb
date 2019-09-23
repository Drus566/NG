class LikesController < ApplicationController
    before_action :set_likeable
    before_action :set_like, only: [:update, :destroy]

    def create
        @like = @likeable.likes.new(like_params)
        @like.user = current_user
        respond_to do |format|
            if @like.save
                format.json { render json: @like }
                format.js 
            else
                format.json { render json: @like.errors }
                format.js
            end
        end
    end

    def update 
        respond_to do |format|
            if @like.update(like_params)
                format.json { render json: @like }
                format.js 
            else
                format.json { render json: @Like.errors }
                format.js
            end
        end 
    end

    def destroy
        @like.destroy if @like.errors.empty?
        respond_to do |format|
            format.json { head :no_content }
            format.js
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
