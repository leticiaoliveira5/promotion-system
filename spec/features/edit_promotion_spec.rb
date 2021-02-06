require 'rails_helper'

feature 'edits promotion' do
   
    scenario 'successfully' do

    user = User.create!(email: 'leticia@email.com', password: '123456')
    login_as user, scope: :user

    @promotion = Promotion.create!(name: 'Páscoa', description: 'Promoção de Páscoa',
                      code: 'PASCOA20', discount_rate: 20, coupon_quantity: 100, 
                      expiration_date: '22/12/2033', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'Páscoa'
    click_on 'Editar promoção'
   
    expect(page).to have_button 'Salvar mudanças'
    expect(current_path).to eq(edit_promotion_path(@promotion))

   end

   scenario 'saves changes and redirects to promotion page' do

    user = User.create!(email: 'leticia@email.com', password: '123456')
    login_as user, scope: :user

    @promotion = Promotion.create!(name: 'Páscoa', description: 'Promoção de Páscoa',
                      code: 'PASCOA20', discount_rate: 20,
                      coupon_quantity: 100, expiration_date: '22/12/2033', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'Páscoa'
    click_on 'Editar promoção'
    fill_in 'Quantidade de cupons', with: '500'
    click_on 'Salvar mudanças'

    expect(current_path).to eq(promotion_path(@promotion))
    expect(page).to have_content 'Quantidade de cupons 500'

   end

end