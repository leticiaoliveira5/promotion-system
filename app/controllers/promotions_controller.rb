class PromotionsController < ApplicationController

    def index
        @promotions = Promotion.all 
    end
    
    def new
        @promotion = Promotion.new
    end

    def show
        @promotion = Promotion.find(params[:id])
    end

    def create
    
        promotion_params = params.require(:promotion).permit(:name, 
        :description, :code, :discount_rate, :coupon_quantity, :expiration_date)
        @promotion = Promotion.new(promotion_params)
        
        if @promotion.save
            redirect_to @promotion
        else
            render 'new'
        end
    end
    
    def edit
        @promotion = Promotion.find(params[:id])
    end

    def update
        @promotion = Promotion.find(params[:id])
        @promotion.update(name: params[:promotion][:name], 
        description: params[:promotion][:description], 
        code: params[:promotion][:code],
        discount_rate: params[:promotion][:discount_rate],
        coupon_quantity: params[:promotion][:coupon_quantity],
        expiration_date: params[:promotion][:expiration_date])
        redirect_to promotion_path(@promotion)
    end
          
    def destroy
        @promotion = Promotion.find(params[:id])
        @promotion.destroy
        redirect_to promotions_path
    end

    def generate_coupons
        @promotion = Promotion.find(params[:id])
        (1..@promotion.coupon_quantity).each do |number|
        Coupon.create!(code: "#{@promotion.code}-#{'%04d' % number}", promotion: @promotion)
        end
        flash[:notice] = 'Cupons gerados com sucesso'
        redirect_to @promotion
    end

end