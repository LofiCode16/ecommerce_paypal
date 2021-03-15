# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.destroy_all
Product.destroy_all
OrderItem.destroy_all
Order.destroy_all
PaymentMethod.destroy_all

Category.create(name: 'hogar')
PaymentMethod.create(name: 'PayPal Express Checkout', code: 'PEC')

5.times do

    Product.create(
        [
            {
                name: Faker::House.furniture,
                price: rand(10..500), 
                quant: rand(1..100)
            }
        ]
    )

    Category.last.products << Product.last

end

Category.create(name: 'computacion')

5.times do

    Product.create(
        [
            {
                name: Faker::Computer.type,
                price: rand(100..5000),
                quant: rand(1..100)
            }
        ]
    )

    Category.last.products << Product.last
    Category.first.products << Product.last

end

Category.create(name: 'libros')

5.times do

    Product.create(
        [
            {
                name: Faker::Book.title,
                price: rand(10..500),
                quant: rand(1..100)
            }
        ]
    )

    Category.last.products << Product.last

end