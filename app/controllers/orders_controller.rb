class OrdersController < ApplicationController
  def cart
    @cart = current_user.orders.find_by(status: Order.statuses[:pending])
  end
end
