class ArticlesController < ApplicationController

    # before_action :logged_in_user, only: [:create, :destroy, :new, :edit]
    # before_action :get_post, only: [:destroy, :edit, :show, :update]
    # before_action :get_all_tags, only: [:edit, :new, :index]
    # before_action :valid_post_resource, only: [:destroy, :edit, :update]
    
    before_action :get_article, only: [:destroy, :edit, :show, :update]
    def index
        @articles = Article.all
    end

    def new
        @article = Article.new
    end

    def create
        @article = current_user.articles.build(article_params)

        if @article.save
            flash[:success] = "Новость создана"
            redirect_to articles_path
        else
            flash[:error] = "Новость неверно заполнена или не заполнена"
            render 'new'
        end
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
            params.require(:article).permit(:body, :title)
        end



        # def get_post
        #     @post = Post.find(params[:id])
        # end

        # def post_params
        #     params.require(:post).permit(:content)
        # end

        # def valid_post_resource
        #     valid_resource(@post.user)
        # end

        # def get_all_tags
        #     @all_tags = Tag.all
        # end

end
