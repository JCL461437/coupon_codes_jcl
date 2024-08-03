require 'rails_helper'
RSpec.describe Coupon, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    
    it { should validate_numericality_of :dollar_off }
    it { should validate_numericality_of :percent_off }

    it { should validate_uniqueness_of :unique_code }

    it { should validate_presence_of :percent_off }
    it { should validate_presence_of :dollar_off }
    it { should validate_presence_of :unique_code }
  end

  describe "relationships" do
    it { should have_many :invoices }
    it { should belong_to :merchant }
  end
  
end