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
rich = User.create( username: 'rich', password: 'llllll', password_confirmation: 'llllll', email: 'rich@gmail.com')

me.friends << rich
rich.friends << me


i1 = Item.create( name: 'Cheetah Jacket', size: 'XS', fit: 'big')
i2 = Item.create( name: 'Jeans', size: 'XS', fit: 'right')
i6 = Item.create( name: 'Shirt', size: 'XS', fit: 'big')
i7 = Item.create( name: 'Shoes', size: 'XS', fit: 'right')

me.items << i1 << i2 << i6 << i7

i3 = Item.create( name: 'Industry Jeans', size: '32', fit: 'right')
i4 = Item.create( name: 'Ninefold shirt', size: 'XL', fit: 'big')
i5 = Item.create( name: 'Grey sweater', size: 'M', fit: 'small')

rich.items << i3 << i4 << i5

b3 = Brand.create( name: "ASOS" )
b4 = Brand.create( name: "Adidas" )
b5 = Brand.create( name: "Ben Sherman" )
b6 = Brand.create( name: "Cheap Monday" )
b7 = Brand.create( name: "Don't Ask Amanda" )
b8 = Brand.create( name: "Dope" )
b9 = Brand.create( name: "Dr Denim" )
b10 = Brand.create( name: "Express" )
b11 = Brand.create( name: "Forever 21" )
b12 = Brand.create( name: "GAP" )
b13 = Brand.create( name: "Goat Crew" )
b14 = Brand.create( name: "H&M" )
b15 = Brand.create( name: "Industry" )
b16 = Brand.create( name: "J Crew" )
b17 = Brand.create( name: "Kookai" )
b18 = Brand.create( name: "Nike" )
b19 = Brand.create( name: "Reebok" )
b20 = Brand.create( name: "Stussy" )
b21 = Brand.create( name: "Teefury" )
b22 = Brand.create( name: "Topshop" )
b23 = Brand.create( name: "UNIQLO" )
b24 = Brand.create( name: "Zara" )
b25 = Brand.create( name: "Vila" )
b27 = Brand.create( name: "Just Jeans" )

b7.items << i1
b25.items << i2
b15.items << i3
b27.items << i5

c1 = Category.create( name: 'Outerwear' )
c2 = Category.create( name: 'Tops' )
c3 = Category.create( name: 'Bottoms' )
c4 = Category.create( name: 'Footwear' )
c5 = Category.create( name: 'Accessories' )
c6 = Category.create( name: 'One Piece')

t1 = Type.create( name: 'Coat', warmth: 0.48)
t2 = Type.create( name: 'T-shirt', warmth: 0.1 )
t3 = Type.create( name: 'Shorts', warmth: 0.06 )
t4 = Type.create( name: 'Sneakers', warmth: 0.02 )
t5 = Type.create( name: 'Jewellery', warmth: 0)
t6 = Type.create( name: 'Dress(Short sleeve)', warmth: 0.29)
t7 = Type.create( name: 'Tank Top', warmth: 0.05)
t8 = Type.create( name: 'Jacket(light)/Cardigan', warmth: 0.36)
t9 = Type.create( name: 'Jeans', warmth: 0.24)
t10 = Type.create( name: 'Jacket(Heavy)', warmth: 0.44)
t11 = Type.create( name: 'Jacket', warmth: 0.42)
t12 = Type.create( name: 'Business Shirt', warmth: 0.23 )
t13 = Type.create( name: 'Button up Shirt', warmth: 0.34 )
t14 = Type.create( name: 'Sweater(thick)', warmth: 0.36 )
t15 = Type.create( name: 'Hoodie', warmth: 0.34 )
t16 = Type.create( name: 'Boots', warmth: 0.10 )
t17 = Type.create( name: 'Stockings', warmth: 0.2 )
t18 = Type.create( name: 'Leggings/Tights', warmth: 0.28 )
t20 = Type.create( name: 'Hat', warmth: 0.01 )
t21 = Type.create( name: 'Beanie', warmth: 0.04 )
t22 = Type.create( name: 'Lace up shoes', warmth: 0.02 )
t23 = Type.create( name: 'Pants', warmth: 0.15 )
t24 = Type.create( name: 'Sunglasses', warmth: 0 )
t25 = Type.create( name: 'Skirt(mini)', warmth: 0.14 )
t26 = Type.create( name: 'Skirt(mid)', warmth: 0.17 )
t27 = Type.create( name: 'Skirt(long)', warmth: 0.2 )
t28 = Type.create( name: 'Long sleeve top', warmth: 0.30 )
t29 = Type.create( name: 'Short sleeve top', warmth: 0.19 )
t30 = Type.create( name: 'Crop top', warmth: 0.08 )
t32 = Type.create( name: 'Vest', warmth: 0.10)
t33 = Type.create( name: 'Sweatpants', warmth: 0.28)
t34 = Type.create( name: 'Overalls', warmth: 0.30)
t35 = Type.create( name: 'Socks', warmth: 0.04)
t36 = Type.create( name: 'Dress(long sleeve)', warmth: 0.47)
t37 = Type.create( name: 'Sweater(thin)', warmth: 0.25 )


c1.types << t1 << t8 << t10 << t11 << t14 << t15 << t32 << t37
c2.types << t2 << t7 << t12 << t13 << t28 << t29 << t30
c3.types << t3 << t9 << t17 << t18 << t23 << t25 << t26 << t27 << t33
c4.types << t4 << t16 << t22 << t35
c5.types << t5 << t20 << t21 << t24
c6.types << t6 << t34 << t36

t1.items << i1
t9.items << i2 << i3
t2.items << i4 << i6
t14.items << i5
t22.items << i7