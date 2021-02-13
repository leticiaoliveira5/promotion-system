require 'rails_helper'

feature 'admin deletes promotion' do

    scenario 'and is redirected to promotions page' do

        user = User.create!(email: 'leticia@email.com', password: '123456')
        login_as user, scope: :user

        Promotion.create!(name: 'Páscoa', 
                            description: 'Promoção de Páscoa',
                            code: 'PASCOA20', 
                            discount_rate: 20, 
                            coupon_quantity: 100, 
                            expiration_date: '22/12/2033', 
                            user: user)

        visit root_path
        click_on 'Promoções'
        click_on 'Páscoa'
        click_on 'Apagar promoção'
       
        expect(current_path).to eq(promotions_path)
        expect(page).not_to have_content 'Páscoa'
    
       end

end
