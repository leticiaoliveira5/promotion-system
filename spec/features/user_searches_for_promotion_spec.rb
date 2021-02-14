require 'rails_helper'

feature 'User searches for promotions' do

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
    
        visit root_path
        within('form') do
        fill_in 'XYZ'
        click_on 'Buscar promoção'
        end
        
        expect(current_path).to eq(promotions_search_path)
        expect(page).to have_link 'XYZ'

    end

end
