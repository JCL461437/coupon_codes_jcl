class CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @coupons = @merchant.coupons.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.find(params[:id])
  end

  def new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = @merchant.coupons.find(params[:id])
    if params[:dollar_off].blank? && params[:percent_off].present? || params[:dollar_off].present? && params[:percent_off].empty? # cheks to see if either the dollar is empty and percent is full or percent is pull and dollar is empty. If either is true good to go. 
      Coupon.create!(name: params[:name],
      unique_code: params[:unique_code],
      dollar_off: params[:dollar_off],
      percent_off: params[:percent_off],
      merchant: @merchant)
      redirect_to merchant_coupons_path(@merchant)
    elsif params[:dollar_off].present? && params[:percent_off].present?
      
    else 

    end
  end
end