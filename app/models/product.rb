class Product < ApplicationRecord
    has_and_belongs_to_many :categories

    def self.my_products(id)
        where(user_id: id)
    end
end
