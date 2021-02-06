require 'rails_helper'

feature 'deletes promotion' do

    scenario 'deletes promotion and redirects to promotions page' do

        user = User.create!(email: 'leticia@email.com', password: '123456')
        login_as user, scope: :user

        @promotion = Promotion.create!(name: 'Páscoa', description: 'Promoção de Páscoa',
                          code: 'PASCOA20', discount_rate: 20, coupon_quantity: 100, 
                          expiration_date: '22/12/2033', user: user)
    
        visit root_path
        click_on 'Promoções'
        click_on 'Páscoa'
        click_on 'Apagar promoção'
       
        expect(page).to_not have_content 'Páscoa'
        expect(current_path).to eq(promotions_path)
    
       end

end
