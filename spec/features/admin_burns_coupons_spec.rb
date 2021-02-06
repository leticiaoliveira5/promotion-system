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
        click_on 'Inativar cupon'

        expect(page).to have_content('ABC10-0001 (Inativo)')
        expect(promotion.coupons.reload.active.size).to eq(0)

    end
end