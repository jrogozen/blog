class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    if @categories.length
      render json: @categories
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
    @category = Category.new(category_params)
    if @category.valid?
      @category.name.capitalize!
      @category.save
      render json: @category
    else
      render json: {errors: @category.errors.full_messages}, status: 422
    end
  end

  def destroy
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
