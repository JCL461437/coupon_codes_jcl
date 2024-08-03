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

    Coupon.create!(name: params[:name],
    unique_code: params[:unique_code],
    dollar_off: params[:dollar_off],
    percent_off: params[:percent_off],
    merchant: @merchant)
    redirect_to merchant_coupons_path(@merchant)
  end
end