class OrderItemsController < ApplicationController
  before_action :set_cart

  def create
    @cart.add_item(params[:product])
    render 'orders/cart', layout: false
  end

  def destroy
    item = OrderItem.find(params[:id])
    if current_user != item.order.user
      flash[:danger] = "invalid operation"
    else
      item.destroy
    end
    redirect_to "/cart"
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end
