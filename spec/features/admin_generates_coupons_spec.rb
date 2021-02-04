require 'rails_helper'

feature 'Admin generates coupons' do

    scenario 'of a promotion' do

        @promotion = Promotion.create!(name: 'Páscoa', description: 'Promoção de Páscoa',
        code: 'PASCOA10', discount_rate: 10,
        coupon_quantity: 100, expiration_date: '22/12/2033')

        visit root_path
        click_on 'Promoções'
        click_on 'Páscoa'
        click_on 'Gerar cupons'

        expect(current_path).to eq(promotion_path(@promotion))
        expect(page).to have_content('Cupons gerados com sucesso')
        expect(page).to have_content('PASCOA10-0001')
        expect(page).to have_content('PASCOA10-0002')
        expect(page).to have_content('PASCOA10-0100')
        expect(page).not_to have_content('PASCOA10-0101')

    end

    scenario 'hides button if coupons already generated' do

    @promotion = Promotion.create!(name: 'Páscoa', description: 'Promoção de Páscoa',
        code: 'PASCOA10', discount_rate: 10,
        coupon_quantity: 100, expiration_date: '22/12/2033')

        visit root_path
        click_on 'Promoções'
        click_on 'Páscoa'
        click_on 'Gerar cupons'
        click_on 'Voltar'
        click_on 'Páscoa'
        expect(page).not_to have_content('Gerar cupons')

    end
end