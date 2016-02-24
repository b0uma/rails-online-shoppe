class OrdersController < ApplicationController
  before_action :set_cart

  def cart
  end

  def index
    @orders = current_user.orders.where(status: Order.statuses[:complete])
  end

  def checkout
    if @cart.nil?
      flash[:danger] = 'Order not found'
      redirect_to '/cart'
    else
      @cart.status = Order.statuses[:complete]
      @cart.checkout_time = Time.now
      @cart.save
      current_user.orders.create(status: Order.statuses[:pending])
      @cart.deduct_product_quantities
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
