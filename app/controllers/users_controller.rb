class UsersController < ApplicationController
    
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update]
    before_action :set_user, only: [:get_articles, :get_liked_posts, :get_posts, :get_posts_comments]

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @posts = @user.posts
        @sections = Section.all
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            log_in @user
            flash[:success] = "Добро пожаловать на сайт!"
            redirect_to posts_path
        else
            render 'new'
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update 
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = "Профиль обновлён"
            redirect_to @user
        else
            render 'edit'
        end 
    end

    # ---------- профиль -------------

    def get_posts
        @posts = @user.posts
        render layout: false
    end
    
    def get_posts_comments
        @comments = @user.comments
        render partial: 'comments/comment', colletion: @comments, as: :comment, spacer_template: 'comments/comment_spacer', layout: false
    end

    def get_liked_posts
        @likes_ids = @user.likes.where(likeable_type: "Post", vote: true).map(&:likeable_id)
        @liked_posts = Post.where(id: @likes_ids)
        render layout: false
    end

    private 
        # параметры юзера при создании
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end

        def set_user
            @user = User.find(params[:id])
        end
end
