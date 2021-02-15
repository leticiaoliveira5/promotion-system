require 'rails_helper'

feature 'User searches for coupons' do

    scenario 'successfully' do
        user = User.create!(email: 'leticia@email.com', password: '123456')
        login_as user, scope: :user
        promotion = Promotion.create!(name: 'XYZ', 
                                    description: 'Promoção XYZ',
                                    code: 'XYZ10', 
                                    discount_rate: 10, 
                                    coupon_quantity: 2,
                                    expiration_date: '22/12/2025', 
                                    user: user)
        new_coupon = Coupon.create!(code: 'XYZ10-0001', promotion: promotion)
    
        visit root_path
        click_on 'Promoções'
        within('div#coupon_search') do
        fill_in 'Código', with: 'XYZ10-0001'
        click_on 'Buscar cupom'
        end
        
        expect(current_path).to eq(coupon_path(new_coupon))
        expect(page).to have_content('Informações do cupom')
        expect(page).to have_content('Código: XYZ10-0001')
        expect(page).to have_content('Status: Ativo')
        expect(page).to have_content('Promoção: XYZ')
        expect(page).to have_link('XYZ')

    end

    scenario 'and search fails' do
        user = User.create!(email: 'leticia@email.com', password: '123456')
        login_as user, scope: :user
        promotion = Promotion.create!(name: 'XYZ', 
                                    description: 'Promoção XYZ',
                                    code: 'XYZ10', 
                                    discount_rate: 10, 
                                    coupon_quantity: 1,
                                    expiration_date: '22/12/2025', 
                                    user: user)
        new_coupon = Coupon.create!(code: 'XYZ10-0001', promotion: promotion)
    
        visit root_path
        click_on 'Promoções'
        within('div#coupon_search') do
        fill_in 'Código', with: 'XYZ10-0002'
        click_on 'Buscar cupom'
        end
        
        expect(current_path).to eq(promotions_path)
        expect(page).to have_content('O cupom não foi encontrado')


    end


end
