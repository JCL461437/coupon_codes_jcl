# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Rake::Task["csv_load:all"].invoke

merchant = Merchant.create(name: "Craig Jones")
merchant1 = Merchant.where(id: 1)
merchant2 = Merchant.where(id: 2)
merchant3 = Merchant.where(id: 3)
merchant4 = Merchant.where(id: 4)
merchant5 = Merchant.where(id: 5)
merchant6 = Merchant.where(id: 6)
merchant7 = Merchant.where(id: 7)
merchant8 = Merchant.where(id: 8)
merchant9 = Merchant.where(id: 9)
merchant10 = Merchant.where(id: 10)
merchant11 = Merchant.where(id: 11)
merchant12 = Merchant.where(id: 12)
merchant13 = Merchant.where(id: 13)
merchant14 = Merchant.where(id: 14)
merchant15 = Merchant.where(id: 15)

puts "Merchants established for coupon creation."

coupon1 = Coupon.create!(name: "Five Dollars Off!", unique_code: "A238HFSD82", dollar_off: 500, percent_off: 0, merchant: merchant )
coupon2 = Coupon.create!(name: "Five Percent Off!", unique_code: "GL12FG3FJ6", dollar_off: 0, percent_off: 0.05, merchant: merchant )
coupon3 = Coupon.create!(name: "Twenty Dollars Off!", unique_code: "12ASFSSFJ6", dollar_off: 2000, percent_off: 0, merchant: merchant )
# coupon3 =
# coupon4 =
# coupon5 =
# coupon6 =
# coupon7 =
# coupon8 = 
# coupon9 =
# coupon10 =
# coupon11 =
# coupon12 =
# coupon13 =
# coupon14 =
# coupon15 =
# coupon16 = 
# coupon17 =
# coupon18 =
# coupon19 =
# coupon20 =
# coupon21 =
# coupon22 =
# coupon23 =
# coupon24 =
# coupon25 =
# coupon26 =
# coupon27 =
# coupon28 =
# coupon29 =
# coupon30 =

# puts "Invoices established for coupon creation."


puts "Successfully Seeded"