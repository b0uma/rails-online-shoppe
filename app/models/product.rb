class Product < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :order_items, dependent: :destroy

  validates :name, :price, :description, :image_url, :quantity, presence: true
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :quantity, greater_than: -1
end
