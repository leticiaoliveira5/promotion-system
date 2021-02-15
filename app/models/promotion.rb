class Promotion < ApplicationRecord
    belongs_to :user
    has_many :coupons, dependent: :destroy
    has_one :promotion_approval, dependent: :destroy
    has_many :product_category_promotions
    has_many :product_categories, through: :product_category_promotions

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
    
    def self.search(search)
      if search
          self.where("name LIKE ?","%#{search}%")
          # sintaxe SQL para buscas no banco de dados
          # Like procura o texto independente da posição na string
      else
          @promotions = Promotion.all
      end
    end
 
end
