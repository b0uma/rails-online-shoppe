class User < ActiveRecord::Base
  has_secure_password
  validates :name, :email, :password_digest, presence: true

  has_many :orders, dependent: :destroy

  after_commit :create_initial_order

  def cart
    orders.includes(order_items: [:product]).find_by(status: Order.statuses[:pending])
  end

  private

  def create_initial_order
    orders.create(status: Order.statuses[:pending]) if orders.blank?
  end
end
