class PostsController < ApplicationController
    # protect_from_forgery except: :show

    include TagsHelper
    before_action :logged_in_user, only: [:create, :destroy, :new, :edit]
    before_action :get_post, only: [:destroy, :edit, :show, :update]
    # before_action :get_all_tags, only: [:edit, :new]
    before_action :valid_post_resource, only: [:destroy, :edit, :update]
    
    def index 
        @posts = Post.all
        @tags = Tag.all
    end

    def create
        @user = User.first
        # @active_ids = params[:active_tags]
        @post = @user.posts.build(post_params)
        # add_tags(@active_ids, @post)
        if @post.save
            flash[:success] = "Пост создан"
            redirect_to posts_path
        else
            render "posts/index"
        end
    end

    def edit
        # @post_tags = Post.tags
        # @tags = elimination_exist_elems(@post_tags, @all_tags)
    end

    def new
        @post = current_user.posts.build if logged_in?
        # @tags = @all_tags
    end

    def show
        @some_post = Post.first
        # @token = form_authenticity_token
        respond_to do |format|
          if @post_layer = @post
            format.html { redirect_to action: 'index', notice: 'Пост нашелся' }
            # format.js { render :js => alert("GGWP"), :json => @micropost_layer }
            format.js
            format.json { render json: @some_post, status: :ok }
          else
            format.html { redirect_to @posts, notice: 'Нет такого поста' }  
            format.json { render json: @post.errors, status: :unprocessable_entity }
          end
        end
    end

    def update
        # @active_ids = params[:active_tags]
        # @inactive_ids = params[:inactive_tags]
        
        # add_tags(@active_ids, @post)
        # destroy_tags(@inactive_ids, @post)

        if @post.update_attributes(post_params)
          flash[:success] = "Пост обновлён" 
          redirect_to action: 'index'
        else
          render 'edit'
        end 
    end

    def destroy
        @post.destroy 

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

        def get_all_tags
            @all_tags = Tag.all
        end
end
