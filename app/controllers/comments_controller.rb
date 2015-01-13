class CommentsController < ApplicationController
  def index
    begin
      comments = []

      @post = Post.find(params["post_id"])

      @post.comments.each do |com|
        comment = com.attributes
        comment["user_name"] = User.find(com.user_id).name
        comments << comment
      end
      
      render json: comments
    rescue
      render json: {errors: @posts.errors.full_messages}, status: 422
    end
  end

  def create
    comment_check = Comment.commentable?(comments_params)
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

  def destroy
    if current_user && current_user.admin
      if Comment.find_by(id: params["id"])
        Comment.destroy(params["id"])
        render json: {success: "Comment deleted"}, status: 200
      else
        render json: {errors: ["Comment not found"]}, status: 422
      end
    else
      render json: {errors: ["Must be an admin"]}, status: 422
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:content, :post_id)
  end
end
