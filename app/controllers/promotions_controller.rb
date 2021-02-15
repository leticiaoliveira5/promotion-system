class PromotionsController < ApplicationController

    before_action :authenticate_user!

    def index

         @promotions = Promotion.search(params[:search])
    
    end
    
    def new
        @promotion = Promotion.new
        @product_categories = ProductCategory.all
    end

    def show
        @promotion = Promotion.find(params[:id])
    end

    def create
    
        promotion_params = params.require(:promotion).permit(:name, 
                                :description, 
                                :code, 
                                :discount_rate, 
                                :coupon_quantity, 
                                :expiration_date, 
                                :search,
                                product_category_ids: [])

        @promotion = Promotion.new(promotion_params)
        @promotion.user = current_user
        
        if @promotion.save
            redirect_to @promotion
        else
            @product_categories = ProductCategory.all
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
        @promotion.destroy!
        redirect_to promotions_path
    end

    def generate_coupons
        @promotion = Promotion.find(params[:id])
        @promotion.generate_coupons!
        redirect_to @promotion, notice: t('.success')
    end

    def approve
        promotion = Promotion.find(params[:id])
        promotion.approve!(current_user)    
        redirect_to promotion
    end

end