class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum status: { pending: 0, complete: 1 }

  validates :status, presence: true
end
