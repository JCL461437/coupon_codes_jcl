FactoryBot.define do
  factory :customer do
    first_name {Faker::Name.first_name}
    last_name {Faker::Dessert.variety}
  end

  factory :invoice do
    status {[0,1,2].sample}
    customer
    coupon
  end

  factory :merchant do
    name {Faker::Space.galaxy}
    status { 1 }
  end

  factory :item do
    name {Faker::Coffee.variety}
    description {Faker::Hipster.sentence}
    unit_price {Faker::Number.decimal(l_digits: 2)}
    status { 0 }
    merchant
  end

  factory :transaction do
    result {[0,1].sample}
    credit_card_number {Faker::Bank.account_number(digits: 6)} # Faker cc number sometimes exceeds integer limit, should cast db to bigint
    invoice
  end

  factory :invoice_item do
    status {[0,1,2].sample}
    unit_price { 100 }
    quantity { 1 }
    item
    invoice
  end

  factory :coupon do
    name {Faker::Name.first_name}
    unique_code {Faker::Number.hexadecimal(digits: 8)} #=> "HR88467617508"
    percent_off {Faker::Number.decimal(l_digits: 4)} # 0.9999 is 99.99% off in conversion so it should be highest value some one can get off
    dollar_off {Faker::Number.decimal} # in cents
    merchant
  end
end
