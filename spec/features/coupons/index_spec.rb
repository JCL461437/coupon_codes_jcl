require "rails_helper"

describe "merchant coupons index" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @merchant2 = Merchant.create!(name: "Jewelry")

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)
    @item_7 = Item.create!(name: "Scrunchie", description: "This holds up your hair but is bigger", unit_price: 3, merchant_id: @merchant1.id)
    @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

    @item_5 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: @merchant2.id)
    @item_6 = Item.create!(name: "Necklace", description: "Neck bling", unit_price: 300, merchant_id: @merchant2.id)

    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
    @customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
    @customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
    @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
    @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
    @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-28 14:54:09")
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 2)

    @invoice_8 = Invoice.create!(customer_id: @customer_6.id, status: 2)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_3.id, quantity: 3, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_7.id, quantity: 1, unit_price: 3, status: 1)
    @ii_8 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_8.id, quantity: 1, unit_price: 5, status: 1)
    @ii_9 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
    @ii_10 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_5.id, quantity: 1, unit_price: 1, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_2.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_3.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_4.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_5.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 0, invoice_id: @invoice_6.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_7.id)
    @transaction8 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_8.id)

    @coupon1 = Coupon.create!(name: "Five Dollars Off!", unique_code: "A238HFSD82", dollar_off: 500, percent_off: 0, merchant: @merchant1 )
    @coupon2 = Coupon.create!(name: "Five Percent Off!", unique_code: "GL12FG3FJ6", dollar_off: 0, percent_off: 0.05, merchant: @merchant1 )
    @coupon3 = Coupon.create!(name: "Twenty Dollars Off!", unique_code: "12ASFSSFJ6", dollar_off: 2000, percent_off: 0, merchant: @merchant2 )
    @coupon4 = Coupon.create!(name: "Five Dollars Off!", unique_code: "A238HFSD82", dollar_off: 500, percent_off: 0, merchant: merchant1 )
    @coupon5 = Coupon.create!(name: "Five Percent Off!", unique_code: "GL12FG3FJ6", dollar_off: 0, percent_off: 0.05, merchant: @merchant1 )
    @coupon6 = Coupon.create!(name: "Twenty Dollars Off!", unique_code: "12ASFSSFJ6", dollar_off: 2000, percent_off: 0, merchant: @merchant1 )
    
    @coupon7 = Coupon.create!(name: "Five Percent Off!", unique_code: "SKLGSKD4", dollar_off: 0, percent_off: 0.05, status: 0, merchant: @merchant1 )
    @coupon8 = Coupon.create!(name: "Twenty Dollars Off!", unique_code: "92KS84JG", dollar_off: 2000, percent_off: 0, status: 0, merchant: @merchant1 )
    @coupon9 = Coupon.create!(name: "Ten Percent Off!", unique_code: "JFKS9182", dollar_off: 0, percent_off: 0.10, status: 0, merchant: @merchant1 )
    @coupon10 = Coupon.create!(name: "Thirty Dollars Off!", unique_code: "FS56SFJ6", dollar_off: 3000, percent_off: 0, status: 0, merchant: @merchant )
  end

  it "can see a link to merchant coupons index page that will bring me to merchant_coupons_path" do
    visit merchant_dashboard_index_path(@merchant1)

    expect(page).to have_content("View All Merchant Coupons")
    
    click_link "View All Merchant Coupons"

    expect(page).to have_current_path(merchant_coupons_path(@merchant1))

    expect(page).to have_content("#{@merchant1.name}")
    expect(page).to have_content("#{@coupon1.name}")
    expect(page).to have_content("Dollar off $#{@coupon1.dollar_off/10}")
    expect(page).to have_content("Percent off #{@coupon1.percent_off*10} %")
    expect(page).to have_content("#{@coupon2.name}")
    expect(page).to have_content("Dollar off $#{@coupon2.dollar_off/10}")
    expect(page).to have_content("Percent off #{@coupon2.percent_off*10} %")

    expect(page).to_not have_content("#{@coupon3.name}")
    
  end

  it "sorts the coupons between active and inactive coupons" do
    visit merchant_coupons_path(@merchant1)

    expect(page).to have_content("Activated Coupons")

    expect(page).to have_content("Deactivated Coupons")

    expect(page).to have_content("#{@merchant1.name}")

    within "#activated" do
      expect(page).to have_content("#{@coupon1.name}")
      expect(page).to have_content("Dollar off $#{@coupon1.dollar_off/10}")
      expect(page).to have_content("Percent off #{@coupon1.percent_off*10} %")
      expect(page).to have_content("#{@coupon2.name}")
      expect(page).to have_content("Dollar off $#{@coupon2.dollar_off/10}")
      expect(page).to have_content("Percent off #{@coupon2.percent_off} %")
      expect(page).to have_content("#{@coupon4.name}")
      expect(page).to have_content("Dollar off $#{@coupon4.dollar_off/10}")
      expect(page).to have_content("Percent off #{@coupon4.percent_off*10} %")
      expect(page).to have_content("#{@coupon5.name}")
      expect(page).to have_content("Dollar off $#{@coupon5.dollar_off/10}")
      expect(page).to have_content("Percent off #{@coupon5.percent_off} %")
      expect(page).to have_content("#{@coupon6.name}")
      expect(page).to have_content("Dollar off $#{@coupon6.dollar_off/10}")
      expect(page).to have_content("Percent off #{@coupon6.percent_off} %")

      expect(page).to_not have_content("#{@coupon1.name}")
      expect(page).to_not have_content("Dollar off $#{@coupon1.dollar_off/10}")
      expect(page).to_not have_content("Percent off #{@coupon1.percent_off*10} %")
    end
    
    within "#deactivated" do
      expect(page).to have_content("#{@coupon7.name}")
      expect(page).to have_content("Dollar off $#{@coupon7.dollar_off/10}")
      expect(page).to have_content("Percent off #{@coupon7.percent_off*10} %")
      expect(page).to have_content("#{@coupon8.name}")
      expect(page).to have_content("Dollar off $#{@coupon8.dollar_off/10}")
      expect(page).to have_content("Percent off #{@coupon8.percent_off} %")
      expect(page).to have_content("#{@coupon9.name}")
      expect(page).to have_content("Dollar off $#{@coupon9.dollar_off/10}")
      expect(page).to have_content("Percent off #{@coupon9.percent_off*10} %")
      expect(page).to have_content("#{@coupon10.name}")
      expect(page).to have_content("Dollar off $#{@coupon10.dollar_off/10}")
      expect(page).to have_content("Percent off #{@coupon10.percent_off} %")
      expect(page).to have_content("#{@coupon6.name}")
    
      expect(page).to_not have_content("#{@coupon1.name}")
      expect(page).to_not have_content("Dollar off $#{@coupon1.dollar_off/10}")
      expect(page).to_not have_content("Percent off #{@coupon1.percent_off*10} %")
    end
  end
end
