class CouponsController < ApplicationController

  before_action :authenticate_user!

  def show
    @coupon = Coupon.find(params[:id])
  end

  def inactivate
    @coupon = Coupon.find(params[:id])
    @coupon.inactive!
    redirect_to @coupon
  end

  def activate
    @coupon = Coupon.find(params[:id])
    @coupon.active!
    redirect_to @coupon
  end

  def index
    @coupons = Coupon.all
  end

  def search
    coupon = Coupon.find_by(code: params[:code])
    if coupon.present?
    redirect_to coupon_path(coupon.id)
    else
    redirect_to promotions_path, notice: "O cupom não foi encontrado"
    end
  end
end