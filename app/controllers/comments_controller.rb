class CommentsController < ApplicationController

    before_action :set_commentable
    before_action :set_comment, only: [:reply, :edit, :update, :destroy]
    before_action :logged_in_user, only: [:create, :destroy, :new, :edit]
    before_action :valid_comment_resource, only: [:destroy, :edit, :update]

    def reply
        @reply = @commentable.comments.build(parent: @comment)
        render layout: false
    end

    def create
        @comment = @commentable.comments.new(comment_params)
        @comment.user = current_user
        if @comment.save 
            render layout: false
        end
    end

    def edit 
        render layout: false
    end

    def update 
        if @comment.update(comments_params)
            render @comment, layout: false
        end
    end

    def new
        @new_comment = @commentable.comments.build
        render layout: false
    end

    def destroy
        @comment.destroy if @comment.errors.empty?
        head :ok
    end

    private 

        def set_commentable
            resource, id = request.path.split('/')[1,2]
            @commentable = resource.singularize.classify.constantize.find(id)
        end

        def set_comment
            begin
                @comment = @commentable.comments.find(params[:id])
            rescue => e
                logger.error "#{e.class.name} : #{e.message}"
                @comment = @commentable.comments.build
                @comment.errors.add(:base, :recordnotfound, message: "Эта запись не существует, возможно удалена")
            end
        end

        def comment_params
            params.require(:comment).permit(:content, :parent_id)
        end

        def valid_comment_resource
            valid_resource(@comment.user)
        end
end
