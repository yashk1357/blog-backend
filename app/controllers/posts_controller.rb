class PostsController < ApplicationController
    before_action :authenticate_request
    before_action :get_post, only: [:show, :update, :delete]
    def index 
       @posts = current_user.posts.order(created_at: :desc)
       render json: { data: @posts }, status: :ok        
    end

    def all_posts
        @posts = Post.all
        render json: { data: @posts }, status: :ok     
    end

    def create
       @post = Post.create(post_params)
       @post.account = current_user
       
       if @post.save
        render json: { data: {post: @posts}, message: "post created successfully" }, status: :ok
       else
        render json: { data: {post: @posts}, message: @post.errors }, status: :unprocessible_entity
       end
    end

    def update
        if @post.account_id == current_user.id
            if @post.update(post_params)
            render json: { data: {post: @posts}, message: "post updated successfully" }, status: :ok
            else
            render json: { data: {post: @posts}, message: @post.errors }, status: :unprocessible_entity
            end
        else
            render json: {message: "You are not authoriset to edit this post" } , status: :unauthorised
        end
    end

    def show
        render json: @post, status: :ok
    end

    def delete
        @post.destroy!
        render json: @post, status: :ok
    end

    private

    def post_params
        params.permit(:title, :description, :image)
    end

    def get_post
        @post = Post.find_by(id: params[:id])
    end

end
