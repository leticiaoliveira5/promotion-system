class ProductCategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @product_categories = ProductCategory.all
  end

  def new
    @product_category = ProductCategory.new
  end

  def show
    @product_category = ProductCategory.find(params[:id])
  end

  def create
    product_category_params = params.require(:product_category).permit(:name, :code)
    @product_category = ProductCategory.new(product_category_params)
    if @product_category.save
      redirect_to @product_category
    else
      render 'new'
    end
  end

  def edit
    @product_category = ProductCategory.find(params[:id])
  end

  def update
    @product_category = ProductCategory.find(params[:id])
    @product_category.update(name: params[:product_category][:name],
                             code: params[:product_category][:code])
    redirect_to product_category_path(@product_category)
  end

  def destroy
    @product_category = ProductCategory.find(params[:id])
    @product_category.destroy
    redirect_to product_categories_path
  end
end
