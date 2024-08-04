class Coupon < ApplicationRecord
  validates_presence_of :name,
                        :percent_off,#, { unless: :dollar_off },
                        :dollar_off,#, { unless: :percent_off },
                        :unique_code,
                        :status
  validates_numericality_of :percent_off
  validates_numericality_of :dollar_off
  validates_uniqueness_of :unique_code

  belongs_to :merchant
  has_many :invoices #optional: true

  enum status: {
    inactive: 0,
    active: 1,
  }

  def times_used 
    self.invoices.where("status = ?", 2).joins(:transactions) # find invoices for a coupon where the invoices status is completed, then join the transaction table through invoices, and find the coupons who have invoices who have transactions with a successful transaction
                  .where("result = ?", 1).pluck(:result).count # pluck the results where the result are equal to a success and then count the array
  end


  def deactivated_coupons
    self.where(status: 0)
  end

  def activated_coupons
    self.where(status: 1)
  end
end