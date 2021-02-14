require 'rails_helper'

feature 'User searches for coupons' do

    scenario 'successfully' do
        user = User.create!(email: 'leticia@email.com', password: '123456')
        login_as user, scope: :user
        pc= ProductCategory.create!(name: 'Cristais', code: 'CRYSTAL')
        promotion = Promotion.create!(name: 'XYZ', 
                                    description: 'Promoção XYZ',
                                    code: 'XYZ10', 
                                    discount_rate: 10, 
                                    coupon_quantity: 2,
                                    expiration_date: '22/12/2025', 
                                    user: user,
                                    product_category: pc)
        new_coupon = Coupon.create!(code: 'XYZ10-0001', promotion: promotion)
    
        visit root_path
        click_on 'Promoções'
        click_on 'XYZ'
        within('form') do
        fill_in 'XYZ10-0001'
        click_on 'Buscar'
        end
        
        expect(current_path).to eq(coupon_path(new_coupon))
        expect(page).to have_content('Informações do cupom')
        expect(page).to have_content('Código: XYZ10-0001')
        expect(page).to have_content('Status: Ativo')
        expect(page).to have_content('Promoção: Cristais')
        expect(page).to have_link('Cristais')

    end

    scenario 'and search fails' do
        user = User.create!(email: 'leticia@email.com', password: '123456')
        login_as user, scope: :user
        pc= ProductCategory.create!(name: 'Cristais', code: 'CRYSTAL')
        promotion = Promotion.create!(name: 'XYZ', 
                                    description: 'Promoção XYZ',
                                    code: 'XYZ10', 
                                    discount_rate: 10, 
                                    coupon_quantity: 1,
                                    expiration_date: '22/12/2025', 
                                    user: user,
                                    product_category: pc)
        new_coupon = Coupon.create!(code: 'XYZ10-0001', promotion: promotion)
    
        visit root_path
        click_on 'Promoções'
        click_on 'XYZ'
        within('form') do
        fill_in 'XYZ10-0002'
        click_on 'Buscar'
        end
        
        expect(current_path).to eq(promotion_path(promotion))
        expect(current_path).to have_content('O cupom XYZ10-0002 não existe')


    end


end
