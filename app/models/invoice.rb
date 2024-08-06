class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :coupon, optional: true
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def coupon_total_revenue(coupon)
    if coupon.percent_off.blank?
      # invoice_items.sum("unit_price * quantity as subtotal")
      #   .coupons.select("subtotal - coupon.dollar_off")

    elsif coupon.dollar_off.blank?
      # invoice_items.sum("unit_price * quantity as subtotal")
      #   .coupons.select("subtotal * coupon.dollar_off as percentage")
      #   .select("subtotal - percentage")

      #seperate queries? Call the above and then subtract that from new query? 
      Coupon.where(status:1)
    end
  end
end
