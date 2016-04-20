class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:index, :show]

  def index
    prepare_products_and_categories
  end

  def show
    @cart = current_user.cart
    @categories = Category.all
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product successfully created!"
      redirect_to @product
    else
      flash.now[:danger] = @product.errors.full_messages
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      flash.now[:danger] = @product.errors.full_messages
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url
  end

  def admin
    prepare_products_and_categories
  end

  def update_categories
    product = Product.find(params[:product_id])
    new_categories = Category.pluck(:name).select { |category| params[category] == "1" }
    product.categories = Category.where(name: new_categories)
    product.save
    redirect_to product
  end

  private

  def prepare_products_and_categories
    @categories = Category.all
    if params[:commit] == "Reset" || params[:category].nil?
      @selected_category = @categories.first
      @products = Product.all
    else
      @selected_category = @categories.find_by(id: params[:category])
      @products = @selected_category.products
    end
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :image_url, :quantity)
  end
end
