class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum status: { pending: 0, complete: 1 }

  validates :status, presence: true

  def total_price
    order_items.map(&:cost).reduce(:+)
  end

  def add_item(product_id)
    item = order_items.find_by(product_id: product_id)
    if item.nil?
      order_items.create(product_id: product_id, quantity: 1)
    else
      item.quantity += 1 unless item.quantity >= item.product.quantity
      item.save
    end
  end

end
