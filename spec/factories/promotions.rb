FactoryBot.define do
  factory :promotion do
    name { 'ABC' }
    description { 'Promoção ABC' }
    code { 'ABC10' }
    discount_rate { 10 }
    coupon_quantity { 1 }
    expiration_date { '22/12/2025' }
    user
  end
end
