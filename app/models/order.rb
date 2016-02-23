class Order < ActiveRecord::Base
  belongs_to :user

  enum status: { pending: 0, complete: 1 }

  validates :checkout_time, :status, presence: true
end
