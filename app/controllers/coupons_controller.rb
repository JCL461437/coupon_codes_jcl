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
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])

    if params[:dollar_off].present? && params[:percent_off].present? # If user has filled information for both the dollar and percet columns it will not create a coupon and prompt them to do it again
      flash.notice = "You may only enter a value for either dollar off or percent off."
    #elsif #pass param of unique code into method to query db and make sure it is unique
      #flash.notice = "That code is already assigned to a coupon. Enter a different code."
    else 
      if params[:dollar_off].empty?
        Coupon.create!(name: params[:name],
        unique_code: params[:unique_code],
        dollar_off: 0,
        percent_off: params[:percent_off],
        merchant: @merchant)
        flash.notice = 'Coupon has been created!'
        redirect_to merchant_coupons_path(@merchant)
      elsif params[:percent_off].empty?
        Coupon.create!(name: params[:name],
        unique_code: params[:unique_code],
        dollar_off: params[:dollar_off],
        percent_off: 0,
        merchant: @merchant)
        flash.notice = 'Coupon has been created!'
        redirect_to merchant_coupons_path(@merchant)
      end
    end
  end
end