class UsersController < ApplicationController
    
    include UsersHelper

    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update]
    before_action :set_user, only: [:get_liked_posts, :get_posts, :get_posts_comments]

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @sections = Section.all
    end

    def new
        @user = User.new
        render layout: false
    end

    def create
        @user = User.new(user_params)
        params[:user][:avatar].nil? ? nil : @user.avatar.attach(params[:user][:avatar])
        if @user.save
            log_in @user
            redirect_to posts_path
        else
            render html: helpers.content_tag(:div, @user.errors.first.second, class: 'errors') if @user.errors.any? 
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

    private 

        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end

        def set_user
            @user = User.find(params[:id])
        end
end
