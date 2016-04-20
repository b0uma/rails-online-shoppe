module ProductHelper
  def disable_cart_button?
    @product.quantity == 0 ||
    current_user.nil? ||
    @product.quantity == @cart.order_items.find_by(product: @product).try(:quantity)
  end
end
