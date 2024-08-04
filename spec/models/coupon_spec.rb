require 'rails_helper'
RSpec.describe Coupon, type: :model do
  before (:each) do 
    merchant = Merchant.create(name: "Craig Jones")
    coupon1 = Coupon.create(name: "Five Dollars Off!", unique_code: "A238HFSD82", dollar_off: 500,  percent_off: 0, merchant: merchant )
    coupon2 = Coupon.create(name: "Five Percent Off!", unique_code: "GL12FG3FJ6", dollar_off: 0, percent_off: 0.05, merchant: merchant )
  end

  describe "validations" do
    subject { Coupon.create(name: "Test Coupon", unique_code: "B1290SA8S2", percent_off: 0) }
    it { should validate_presence_of :name }
    
    it { should validate_numericality_of :dollar_off }
    it { should validate_numericality_of :percent_off }

    it { should validate_uniqueness_of :unique_code }

    # it { should validate_presence_of :percent_off }
    # it { should validate_presence_of :dollar_off }
    # it { should validate_presence_of :unique_code }
  end

  describe "relationships" do
    it { should have_many :invoices }
    it { should belong_to :merchant }
  end
  
  describe "model methods" do
    describe "class methods" do

    end

    describe "instance methods" do
      
    end
  end
end