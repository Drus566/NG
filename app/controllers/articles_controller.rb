class ArticlesController < ApplicationController
    
    before_action :get_article, only: [:destroy, :edit, :show, :update]
    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def create
    end

    def show
        
    end 

    def edit
    end

    def update
    end
    
    def destroy 
    end

    private 

        def get_article
            @article = Article.find(params[:id])
        end

        def article_params
            params.require(:article).permit(:body)
        end

end
