class Merchant < ApplicationRecord
  validates_presence_of :name
  # validates_each :coupons do |merchant, attr, value|
  #   user.errors.add attr, "Too many coupons for a merchant" if merchant.coupons.size > merchant.coupons_limit
  # end
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  has_many :coupons

  enum status: [:enabled, :disabled]

  def favorite_customers
    transactions.joins(invoice: :customer)
                .where('result = ?', 1)
                .where("invoices.status = ?", 2)
                .select("customers.*, count('transactions.result') as top_result")
                .group('customers.id')
                .order(top_result: :desc)
                .distinct
                .limit(5)
  end

  def ordered_items_to_ship
    invoice_items.where("invoice_items.status = 0 OR invoice_items.status = 1").order(:created_at)
  end

  def top_5_items
    items
    .joins(invoices: :transactions)
    .where('transactions.result = 1')
    .select("items.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
    .group(:id)
    .order('total_revenue desc')
    .limit(5)
  end

  def self.top_merchants
    joins(invoices: [:invoice_items, :transactions])
    .where('result = ?', 1)
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .group(:id)
    .order('total_revenue DESC')
    .limit(5)
  end

  def best_day
    invoices.where("invoices.status = 2")
            .joins(:invoice_items)
            .select('invoices.created_at, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
            .group("invoices.created_at")
            .order("revenue desc", "invoices.created_at desc")
            .first&.created_at&.to_date
  end

  def enabled_items
    items.where(status: 1)
  end

  def disabled_items
    items.where(status: 0)
  end

  def merchant_coupon_revenue(coupon)
    if coupon.percent_off.blank?
      Invoice.joins(invoice_items: :item)
      .joins(:coupon)
      .group("invoices.id")
      .select("invoices.id, sum(invoice_items.unit_price * invoice_items.quantity) - (max(coupons.dollar_off)) as total_revenue")
      
      # having invoices.id tells us which invoice our total_revenue corresponds to. Important for our aggregate functions to know within context of our group statement

      # Invoice.joins(invoice_item: :items)
      # .group("invoices.id")
      # .select("sum(invoice_items.unit_price * invoice_items.quantity) - max(coupons.dollar_off) as total_revenue")
      # .select("sum(total_revenue)")

      # must join invoices and items to callculate the subtotal for each invoice by summing unit_price and quantity for all items on the invoice also allows us to access coupon details for each invoice
    elsif coupon.dollar_off.blank?
      # invoice_items.sum("unit_price * quantity as subtotal")
      #   .coupons.select("subtotal * coupon.dollar_off as percentage")
      #   .select("subtotal - percentage")

      #seperate queries? Call the above and then subtract that from new query? 

    end
  end
end
