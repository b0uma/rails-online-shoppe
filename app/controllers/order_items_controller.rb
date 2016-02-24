class OrderItemsController < ApplicationController
  def create
    @cart.add_item(params[:product])
    render 'cart', layout: false
  end

  def delete
  end

  private

  def set_cart
    @cart = current_user.cart
  end
end
