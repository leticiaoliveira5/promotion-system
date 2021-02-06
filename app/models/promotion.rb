class Promotion < ApplicationRecord
    has_many :coupons
    belongs_to :user
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
end
