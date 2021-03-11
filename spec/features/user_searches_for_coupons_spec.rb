require 'rails_helper'

feature 'User searches for coupons' do
  scenario 'successfully' do
    user = create(:user)
    login_as user, scope: :user
    promotion = create(:promotion, user: user)
    new_coupon = Coupon.create!(code: 'ABC10-0001', promotion: promotion)

    visit root_path
    click_on 'Promoções'
    within('div#coupon_search') do
      fill_in 'Código', with: 'ABC10-0001'
      click_on 'Buscar cupom'
    end

    expect(current_path).to eq(coupon_path(new_coupon))
    expect(page).to have_content('Informações do cupom')
    expect(page).to have_content('Código: ABC10-0001')
    expect(page).to have_content('Status: Ativo')
    expect(page).to have_content('Promoção: ABC')
    expect(page).to have_link('ABC')
  end

  scenario 'and search fails' do
    user = create(:user)
    login_as user, scope: :user
    promotion = create(:promotion, user: user)
    Coupon.create!(code: 'ABC10-0001', promotion: promotion)

    visit root_path
    click_on 'Promoções'
    within('div#coupon_search') do
      fill_in 'Código', with: 'ABC10-0002'
      click_on 'Buscar cupom'
    end

    expect(current_path).to eq(promotions_path)
    expect(page).to have_content('O cupom não foi encontrado')
  end
end
