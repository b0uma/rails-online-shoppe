class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates_numericality_of :quantity, greater_than: 0

  def cost
    product.price * quantity
  end
end
