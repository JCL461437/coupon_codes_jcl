require 'rails_helper'
RSpec.describe Coupon, type: :model do
  before (:each) do 
    @merchant = Merchant.create(name: "Craig Jones")

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
    
    @coupon1 = Coupon.create!(name: "Five Dollars Off!", unique_code: "A238HFSD82", dollar_off: 500, percent_off: 0, merchant: @merchant1 )
    @coupon2 = Coupon.create!(name: "Five Percent Off!", unique_code: "GL12FG3FJ6", dollar_off: 0, percent_off: 0.05, merchant: @merchant1 )
    @coupon3 = Coupon.create!(name: "Twenty Dollars Off!", unique_code: "12ASFSSFJ6", dollar_off: 2000, percent_off: 0, merchant: @merchant2 )
    @coupon4 = Coupon.create!(name: "Five Percent Off!", unique_code: "SKLGSKD4", dollar_off: 0, percent_off: 0.05, status: 0, merchant: @merchant2 )
    @coupon5 = Coupon.create!(name: "Twenty Dollars Off!", unique_code: "92KS84JG", dollar_off: 2000, percent_off: 0, status: 0, merchant: @merchant1 )
    @coupon6 = Coupon.create!(name: "Ten Percent Off!", unique_code: "JFKS9182", dollar_off: 0, percent_off: 0.10, status: 0, merchant: @merchant1 )
    @coupon7 = Coupon.create!(name: "Thirty Dollars Off!", unique_code: "FS56SFJ6", dollar_off: 3000, percent_off: 0, status: 0, merchant: @merchant2 )
    
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 1, created_at: "2012-03-28 14:54:09", coupon: @coupon1 )
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2, coupon: @coupon1 )
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2, coupon: @coupon1 )
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 1, coupon: @coupon1 )

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
  end

  describe "validations" do
    subject { Coupon.create(name: "Test Coupon", unique_code: "B1290SA8S2", percent_off: 0) }
    it { should validate_presence_of :name }
    
    it { should validate_numericality_of :dollar_off }
    it { should validate_numericality_of :percent_off }

    it { should validate_uniqueness_of :unique_code }

    it { should validate_presence_of :percent_off }
    it { should validate_presence_of :dollar_off }
    it { should validate_presence_of :unique_code }
    it { should validate_presence_of :status}
  end

  describe "relationships" do
    it { should have_many :invoices }
    it { should belong_to :merchant }
  end
  
  describe "model methods" do
    describe "class methods" do
      describe "#deactivated_coupons"
        it "should return all coupons that are deactivated" do
          expect(Coupon.deactivated_coupons).to eq([@coupon4, @coupon5, @coupon6, @coupon7]) 
        end
      end

      describe "#activated_coupons"
        it "should return all coupons that are activated" do
          expect(Coupon.activated_coupons).to eq([@coupon1, @coupon2, @coupon3])) 
        end
      end
    end

    describe "instance methods" do
      describe ":times_used"
        it "should return the number of times a coupon was used for only successful transactions" do
          # should only return two successful transactions, due to the associations between invoices who status must be completed, 
          # and transactiosn whose result must be success. Even though their are three coupons one is associated to invoice that is not completed
          expect(@coupon1.times_used).to eq(2) # pluck array would return "success" two times in array, but counts the number of this
        end
      end
    end
  end
end