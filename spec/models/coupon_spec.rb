require 'rails_helper'

describe Merchant do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :percent_off }
    it { should validate_presence_of :dollar_off }
    it { should validate_presence_of :unique_code}

    it {should validates_numericality_of :dollar_off}
    it {should validates_numericality_of :dollar_off}

    it {should validates_uniqueness_of :unique_code}
  end
  describe "relationships" do
    it { should have_many :invoices }
    it { should belong_to :merchant }
  end

end