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
    name
    unique_code
    percent_off
    dollar_off
    merchant
  end
end
