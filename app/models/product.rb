class Product < ApplicationRecord
    has_many :cart_items, dependent: :destroy
    has_many :order_items, dependent: :destroy
  
    validates :name, :price, :stock, presence: true
    validates :price, numericality: { greater_than: 0 }
end
