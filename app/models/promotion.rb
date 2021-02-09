class Promotion < ApplicationRecord
    has_many :coupons
    belongs_to :user
    has_one :promotion_approval
    validates :name, :code, :discount_rate, :coupon_quantity, :expiration_date, presence: true 
    validates :code, uniqueness: true 

    def generate_coupons!
        Coupon.transaction do
          (1..coupon_quantity).each do |number|
            coupons.create!(code: "#{code}-#{'%04d' % number}")
          end
        end
    end

    def coupons?
      coupons.any?
    end

    def approve!(approval_user)
      PromotionApproval.create(promotion: self, user: approval_user)
    end
  
    def approved?
      promotion_approval
    end
  
    def approved_at
      promotion_approval&.approved_at
  
      return nil unless promotion_approval
      promotion_approval.approved_at
    end
  
    def approver
      promotion_approval.user
    end


end
