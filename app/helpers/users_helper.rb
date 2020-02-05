module UsersHelper
    
    def get_posts
        @posts = @user.posts
        render partial: 'users/get_posts', layout: false
    end

    def get_posts_comments
        @comments = @user.comments
        render partial: 'users/get_posts_comments', layout: false
    end

    def get_liked_posts
        @likes_ids = @user.likes.where(likeable_type: "Post", vote: true).map(&:likeable_id)
        @posts = Post.where(id: @likes_ids)
        render partial: 'users/get_liked_posts', layout: false
    end
end