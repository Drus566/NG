class TagsController < ApplicationController
    def create
        @tag = Tag.new
        @tag.name = params[:tag_name]
        
        respond_to do |format|
            if @tag.save
                format.html { redirect_to @tags, notice: 'Метка была успешно создана'}
                format.js
                format.json { render json: @tag, status: :created, location: @tag }
            else
            # format.html { redirect_to controller: "welcome", action: "index" }  
                format.json { render json: @tag.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
    end

    def index
        @tags = Tag.all
    end

    def show
        @tag = Tag.find(params[:id])
        @tags = Tag.all
        @posts = @tag.posts

        respond_to do |format|
            if @posts
                format.html { render 'posts/index', notice: 'Посты по метке нашлись'}
                format.js
                format.json { render json: @posts, status: :ok }
            else
                format.html { redirect_to @posts, notice: 'Нет постов по метке' }  
                format.json { render json: @tag.errors, status: :unprocessable_entity }
            end
        end
    end

    def results
        @tags = Tag.where("name ILIKE ?", '%' + params[:query] + '%') 
    end
end
