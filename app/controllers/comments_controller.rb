class CommentsController < ApplicationController
    before_action :set_commentable, only: [:new]
    before_action :set_comment, only: [:reply, :edit, :update, :destroy]

    def reply
        @reply = @commentable.comments.build(parent: @comment)
    end

    def create
        @user = User.first
        @commentable = params[:commentable]
        @commentable = Post.find(@commentable)
        @comment = @commentable.comments.new(comment_params)
        @comment.user = @user
        respond_to do |format|
            if @comment.save
                format.html { redirect_to @commentable, notice: "Comment was sucessfully created" }
                format.json { render json: @comment }
                format.js 
            else
                format.html { render :back, notice: "Comment was not created." }
                format.json { render json: @comment.errors }
                format.js
            end
        end
    end

    def edit 
    end

    def update 
        respond_to do |format|
            if @comment.update(comment_params)
                format.html { redirect_to @commentable, notice: "Comment was sucessfully updated" }
                format.json { render json: @comment }
                format.js 
            else
                format.html { render :back, notice: "Comment was not updated" }
                format.json { render json: @comment.errors }
                format.js
            end
        end 
    end

    def new
        @comment = @commentable.comments.build
    end

    def destroy
        @comment.destroy if @comment.errors.empty?
        respond_to do |format|
            format.html { redirect_to @commentable, notice: "Comments was successfully destroyed" }
            format.json { head :no_content }
            format.js
        end
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
                @comment.errors.add(:base, :recordnotfound, message: "That record doesn't exist. Maybe, it is already destroyed")
            end
        end

        def comment_params
            params.require(:comment).permit(:content, :parent_id)
        end
end
