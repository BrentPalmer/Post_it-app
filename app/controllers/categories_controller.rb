class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :require_user, only: [:new, :create]
  #before_action :require_admin, only: [:new, :create]

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Category was successfully created!"
      redirect_to posts_path
    else
      render :new
    end
  end

private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find_by slug: params[:id]
  end

end