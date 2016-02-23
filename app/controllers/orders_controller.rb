class OrdersController < ApplicationController
  def cart
    @cart = current_user.orders.includes(order_items: [:product]).find_by(status: Order.statuses[:pending])
  end
end
