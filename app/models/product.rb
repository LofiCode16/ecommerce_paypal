class Product < ApplicationRecord
    has_and_belongs_to_many :categories
    has_many :order_items
    has_many :orders, through: :order_items

    validates :name, presence: true
    validates :price, numericality: { greater_than_or_equal_to: 10 }

    def self.my_products(id)
        where(user_id: id)
    end
end
