class CommentsController < ApplicationController
  def index
    begin
      @post = Post.find(params["post_id"])
      render json: @post.comments
    rescue
      render json: {errors: @posts.errors.full_messages}, status: 422
    end
  end

  def create
    comment_check = commentable?(comments_params)
    if comment_check.length > 0
      render json: {errors: comment_check}, status: 422
    elsif !current_user
      render json: {errors: ["Must be logged in"]}, status: 422
    else
      @comment = Comment.new(comments_params)
      @comment.user_id = current_user.id
      if @comment.valid?
        @comment.save
        render json: @comment
      else
        render json: {errors: @comment.errors.full_messages}, status: 422
      end
    end
  end

  private

  def commentable?(data)
    errors = []
    errors << "Post does not exist" if !Post.find_by(id: data["post_id"])
    errors << "No content to add to comment" if !data["content"]
    return errors
  end

  def comments_params
    params.require(:comment).permit(:content, :post_id)
  end
end
