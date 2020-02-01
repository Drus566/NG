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

        if @posts
            render 'posts/index'
        end 
    end

    # def results
    #     @tags = Tag.where("name ILIKE ?", '%' + params[:query] + '%') 
    # end
end
