class CouponsController < ApplicationController

    before_action :authenticate_user!


def inactivate
    @coupon = Coupon.find(params[:id])
    @coupon.inactive!
    redirect_to @coupon.promotion
end

def activate
    @coupon = Coupon.find(params[:id])
    @coupon.active!
    redirect_to @coupon.promotion
end

def index
    @coupons = Coupon.all
 end

def show
    @coupon = Coupon.find(params[:id])
end

def search

    if @coupon.exists?
        redirect_to coupon_path(@coupon.id)
    else
        error message
    end    
    
end

end