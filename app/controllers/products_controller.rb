class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:index, :show]

  def index
    @products = Product.all
  end

  def show
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
    @products = Product.all
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :image_url, :quantity)
  end
end
