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
  end

  def destroy
  end
end
