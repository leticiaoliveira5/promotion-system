require 'rails_helper'

feature 'Admin inactivates coupon' do
   scenario 'successfully' do

       promotion = Promotion.create!(name: 'ABC', description: 'Promoção ABC',
       code: 'ABC10', discount_rate: 10, coupon_quantity: 1,
       expiration_date: '22/12/2025')
       promotion.generate_coupons!

       visit root_path
       click_on 'Promoções'
       click_on promotion.name
       click_on 'Inativar cupom'

       expect(page).to have_content('ABC10-0001 (Inativo)')
       expect(promotion.coupons.reload.active.size).to eq(0)
       expect(promotion.coupons.inactive.size).to eq(1)

   end

   scenario 'does not view button when cupon inactive' do

       promotion = Promotion.create!(name: 'DEF', description: 'Promoção DEF',
       code: 'DEF10', discount_rate: 10, coupon_quantity: 2,
       expiration_date: '22/12/2025')
       inactive_coupon = Coupon.create!(code: 'DEF10-0001', promotion: promotion, status: :inactive)
       active_coupon = Coupon.create!(code: 'DEF10-0002', promotion: promotion)

       visit root_path
       click_on 'Promoções'
       click_on promotion.name

       expect(page).to have_content('DEF10-0001 (Inativo)')
       expect(page).to have_content('DEF10-0002 (Ativo)')
       expect(page).to have_link 'Inativar cupom', count: 1


   end

end