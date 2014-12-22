class PostsController < ApplicationController
  def index
    @posts = Post.all
    if @posts.length
      render json: @posts
    else
      render json: {errors: @posts.errors.full_messages}, status: 422
    end
  end

  def create
  end

  def show
    begin
      @post = Post.find(params["id"])
      render json: @post
    rescue
      render json: {errors: "No Post Found"}, status: 422
    end
  end
end
