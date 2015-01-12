class CommentsController < ApplicationController
  def index
    begin
      @post = Post.find(params["post_id"])
      render json: @post.comments
    rescue
      render json: {errors: @posts.errors.full_messages}, status: 422
    end
  end
end
