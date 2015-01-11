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
    if current_user && current_user.admin
      @post = Post.new(post_params)
      if @post.valid?
        @post.save
        @post.create_blurb
        render json: @post
      else
        render json: {errors: @post.errors.full_messages}, status: 422
      end
    else
      render json: {errors: "Only admins can do this"}, status: 422
    end
  end

  def show
    begin
      @post = Post.find(params["id"])
      render json: @post
    rescue
      render json: {errors: "No Post Found"}, status: 422
    end
  end

  def update
    if current_user && current_user.admin
      begin
        @post = Post.find(params["id"])
        if @post.update_attributes(post_params)
          render json: @post
        else
          binding.pry
          render json: {errors: "Post Did Not Update"}, status: 422
        end
      rescue
        render json: {errors: "Post Not Found"}, status: 422
      end
    else
      render json: {errors: "Only admins can do this"}, status: 422
    end
  end

  def destroy
    if current_user && current_user.admin
      begin
        @post = Post.find(params["id"])
        Post.destroy(params["id"])
        render json: {success: "Post Deleted"}, status: 200
      rescue
        render json: {errors: "Post Not Found"}, status: 422
      end
    else
      render json: {errors: "Onl admins can do this"}, status: 422
    end
  end

  private

  def post_params
    params.require(:post).permit(:name, :content, :category_id, :blurb)
  end
end
