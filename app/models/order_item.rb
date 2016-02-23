class OrderItem < ActiveRecord::Base
  belongs_to :products
  belongs_to :orders

  validates_numericality_of :quantity, greater_than: 0
end
