class Promotion < ApplicationRecord

    validates :name, :discount_rate, :coupon_quantity, :code, :expiration_date, presence: true


end
