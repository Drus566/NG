class PostsController < ApplicationController

    # protect_from_forgery 
    include RinkuHelper
    include SectionsHelper

    before_action :logged_in_user, only: [:create, :destroy, :new, :edit]
    before_action :get_post, only: [:destroy, :edit, :show, :update]
    before_action :get_all_sections, only: [:new, :edit, :index]
    before_action :valid_post_resource, only: [:destroy, :edit, :update]
    
    def index 
        @posts = Post.all
    end

    def create
        @post = current_user.posts.build(post_params)
        @post.section = check_section unless check_section.nil?
        if @post.save
            redirect_to posts_path
        else
            render 'new'
        end
    end

    def edit
        respond_to do |format|
            format.html { render :nothing => true }
            format.js { render partial: 'posts/content' }
        end
    end

    def new
        @post = current_user.posts.build if logged_in?
        respond_to do |format|
            format.html { render :nothing => true }
            format.js { render partial: 'posts/content' }
        end
    end

    def update
        @post.section = check_section unless check_section.nil?
        if @post.update_attributes(post_params) 
            redirect_to action: 'index'
        else
            render 'edit'
        end 
    end

    def destroy
        @post.destroy 
        flash[:success] = 'Пост удалён'
        respond_to do |format|
            format.html { redirect_to posts_url }
            format.json { head :no_content }
        end
    end

    private 

        def get_post
            @post = Post.find(params[:id])
        end

        def post_params
            params.require(:post).permit(:content)
        end

        def valid_post_resource
            valid_resource(@post.user)
        end

        def get_all_sections
            @sections = Section.all
        end
end
