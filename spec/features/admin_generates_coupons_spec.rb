require 'rails_helper'

feature 'Admin generates coupons' do
  scenario 'of a promotion' do
    user = create(:user)
    promotion = create(:promotion, coupon_quantity: '100', user: user)
    approval_user = create(:user, email: 'maria@email.com')
    login_as approval_user, scope: :user
    visit promotion_path(promotion)
    click_on 'Aprovar Promoção'
    click_on 'Gerar cupons'

    expect(current_path).to eq(promotion_path(promotion))
    expect(page).to have_content('Cupons gerados com sucesso')
    expect(page).to have_content('ABC10-0001')
    expect(page).to have_content('ABC10-0002')
    expect(page).to have_content('ABC10-0100')
    expect(page).not_to have_content('ABC10-0101')
  end

  scenario 'and hides button if coupons already generated' do
    user = create(:user)
    promotion = create(:promotion, user: user)
    approval_user = create(:user, email: 'maria@email.com')

    login_as approval_user, scope: :user
    visit promotion_path(promotion)
    click_on 'Aprovar Promoção'

    visit root_path
    click_on 'Promoções'
    click_on 'ABC'
    click_on 'Gerar cupons'
    click_on 'Voltar'
    click_on 'ABC'
    expect(page).not_to have_content('Gerar cupons')
  end
end