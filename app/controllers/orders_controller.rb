class OrdersController < ApplicationController
  before_action :set_cart

  def add_to_cart
    @cart.order_items.create(product_id: params[:product], quantity: 1)
    render 'cart', layout: false
  end

  def cart
  end

  def index
  end

  def checkout
  end

  def show
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end
