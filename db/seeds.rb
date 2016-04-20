# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.destroy_all
Category.destroy_all
Order.destroy_all

User.create(name: 'test_user', email: 'test@test.com', password: 'secret')

sample_user = User.first

Category.create(name: 'Food')
Category.create(name: 'Electronics')
Category.create(name: 'Home Appliances')
Category.create(name: 'Fiction')
Category.create(name: 'Workout')

10.times do
  product = Product.create(name: Faker::Commerce.product_name,
                 description: Faker::Lorem.sentence(10),
                 price: Faker::Number.decimal(2),
                 image_url: Faker::Avatar.image,
                 quantity: rand(1..5))
  product.categories = Category.limit(2).order("RANDOM()")
  product.save
end

# out of stock item
Product.create({
 "name"=>"Black Lotus",
 "price"=>999.0,
 "description"=>"very very rare, believe me",
 "image_url"=>
  "http://orig00.deviantart.net/58e2/f/2008/218/d/a/black_lotus_mtg_alter_proxy_by_michaelnoel.jpg",
 "quantity"=>0})

# create a cart, add 2 items, checkout the cart to save the order, then create a new cart
order = sample_user.orders.find_by(status: Order.statuses[:pending])
prod1 = Product.first
prod2 = Product.second
order.order_items.create(product_id: prod1.id, quantity: [1, prod1.quantity - 1].max)
order.order_items.create(product_id: prod2.id, quantity: [1, prod2.quantity - 1].max)
order.deduct_product_quantities
order.update(status: Order.statuses[:complete], checkout_time: Time.now)
sample_user.orders.create(status: Order.statuses[:pending])



