class SectionsController < ApplicationController

    def create
        @section = Section.new
        @section.name = params[:section_name]
        
        respond_to do |format|
            if @section.save
                format.html { redirect_to @section, notice: 'Метка была успешно создана'}
                format.js
            end
        end
    end

    def destroy
    end

    def index
        @sections = Section.all
    end

    def show
        @section = Section.find(params[:id])
        @sections = Section.all
        @posts = @section.posts

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

    # def results
    #     @tags = Tag.where("name ILIKE ?", '%' + params[:query] + '%') 
    # end
end
