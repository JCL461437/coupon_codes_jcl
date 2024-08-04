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
    @coupon = Coupon.new(name: params[:name],
                      unique_code: params[:unique_code],
                      dollar_off: params[:dollar_off],
                      percent_off: params[:percent_off],
                      merchant: @merchant)
    binding.pry
    if params[:dollar_off].present? && params[:percent_off].present? # If user has filled information for both the dollar and percet columns it will not create a coupon and prompt them to do it again
      flash.notice = "You may only enter a value for either dollar off or percent off."
      render :new
    elsif params[:dollar_off].blank? && params[:percent_off].blank?
      flash.notice = "You must ennter a value for either the dollar off or percent off fields. Try again."
      render :new
    elsif @coupon.valid?
      # use blank instead of empty due to nature of empty checking array/hash while blank will more accuratley test this
      @coupon.save
      flash.notice = 'Coupon has been created!'
      render :new
      redirect_to merchant_coupons_path(@merchant)
    else 
      flash.notice = "That code is already assigned to a coupon. Enter a different code."
      render :new
    end
  end
end

# use this if the changes above do not work
# if params[:dollar_off].blank? # use blank instead of empty due to nature of empty checking array/hash while blank will more accuratley test this
#   Coupon.create!(name: params[:name],
#   unique_code: params[:unique_code],
#   dollar_off: 0,
#   percent_off: params[:percent_off],
#   merchant: @merchant)
#   flash.notice = 'Coupon has been created!'
#   redirect_to merchant_coupons_path(@merchant)
# elsif params[:percent_off].blank?
#   Coupon.create!(name: params[:name],
#   unique_code: params[:unique_code],
#   dollar_off: params[:dollar_off],
#   percent_off: 0,
#   merchant: @merchant)
#   flash.notice = 'Coupon has been created!'
#   redirect_to merchant_coupons_path(@merchant)
# end