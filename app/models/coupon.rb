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
end