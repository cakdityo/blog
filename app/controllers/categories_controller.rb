class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @categories = Category.paginate(page: params[:page], per_page: 10)
    @category = Category.new
  end

  def edit
    @categories = Category.paginate(page: params[:page], per_page: 10)
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "New category \"#{@category.name}\" has been added!"
      redirect_to new_category_path
    else
      render 'new'
    end
  end

  def update
    @category = Category.find(params[:id])
    name = @category.name
    if @category.update(category_params)
      flash[:success] = "Category \"#{name}\" has been changed to \"#{@category.name}\""
      redirect_to new_category_path
    else
      render 'new'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:danger] = "\"#{@category.name}\" has been deleted"
    redirect_to new_category_path
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
