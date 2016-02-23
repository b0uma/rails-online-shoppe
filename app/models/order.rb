class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum status: { pending: 0, complete: 1 }

  validates :status, presence: true

  def total_price
    order_items.includes(:product).map(&:cost).reduce(:+)
  end
end
