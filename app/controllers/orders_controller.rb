class OrdersController < ApplicationController
  before_action :set_cart

  def add_to_cart
    @cart.add_item(params[:product])
    render 'cart', layout: false
  end

  def cart
  end

  def index
    @orders = current_user.orders
  end

  def checkout
    @order_to_close = current_user.orders.find(params[:id])
    if @order_to_close.nil?
      flash[:danger] = 'Order not found'
      redirect_to '/cart'
    else
      @order_to_close.status = Order.statuses[:complete]
      @order_to_close.save
      render 'checkout'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end
