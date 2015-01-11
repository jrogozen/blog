class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    if @categories.length
      categories = []
      @categories.each do |cat|
        obj = cat.attributes
        obj["posts"] = Post.where(category_id: obj["id"]).order(:id)
        categories << obj
      end
      render json: categories
    else
      render json: {errors: "No categories found"}, status: 422
    end
  end

  def show
    begin
      @category = Category.find(params[:id])
      render json: @category
    rescue
      render json: {errors: 'No matching category found'}, status: 422
    end
  end

  def create
    if current_user && current_user.admin
      @category = Category.new(category_params)
      if @category.valid?
        @category.name.capitalize!
        @category.save
        render json: @category
      else
        render json: {errors: @category.errors.full_messages}, status: 422
      end
    else
      render json: {errors: "Only admins can do this"}, status: 422
    end
  end

  def destroy
    if current_user && current_user.admin
      begin
        @category = Category.find(params[:id])
        Category.destroy(params[:id])
        render json: {success: "Category deleted"}, status: 200
      rescue
        render json: {errors: ["Category does not exist"]}, status: 422
      end
    else
      render json: {errors: "Only admins can do this"}, status: 422
    end
  end

  def get_default
    begin
      @category = Category.find_by(name: "General")
      render json: @category
    rescue
      render json: {errors: @category.errors.full_messages}, status: 422
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
