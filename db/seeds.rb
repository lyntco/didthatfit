# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Brand.destroy_all
Category.destroy_all
Type.destroy_all
Outfit.destroy_all
Item.destroy_all
User.destroy_all

me = User.create( username: 'lynt', password: 'admin123', password_confirmation: 'admin123', email: 'strawww@gmail.com', is_admin: true)
friend1 = User.create( username: 'buddy', password: 'hahaha', password_confirmation: 'hahaha', email: 'strawww@gmail.com')

# me.friends << friend1

i1 = Item.create( name: 'Cheetah Jacket')
i2 = Item.create( name: 'Jeans')

b1 = Brand.create( name: 'Vivienne Westwood')
b2 = Brand.create( name: 'Ben Sherman')


c1 = Category.create( name: 'Outerwear' )
c2 = Category.create( name: 'Tops' )
c3 = Category.create( name: 'Bottoms' )
c4 = Category.create( name: 'Shoes' )
c5 = Category.create( name: 'Accessories' )
c6 = Category.create( name: 'One Piece')

t1_1 = Type.create( name: 'Coat', warmth: 5)

t2_1 = Type.create( name: 'T-shirt', warmth: 2 )

t3_1 = Type.create( name: 'Shorts', warmth: 2 )

t4_1 = Type.create( name: 'Sneakers', warmth: 2 )

t5_1 = Type.create( name: 'Jewellery', warmth: 0)

t6_1 = Type.create( name: 'Dress', warmth: 3)