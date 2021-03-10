require 'rails_helper'
require 'factory_bot'

feature 'Admin inactivates coupon' do

   scenario 'successfully' do

      user = create(:user)
      login_as user, scope: :user
      promotion = create(:promotion, name: 'ABC', user: user)
      promotion.generate_coupons!

      visit root_path
      click_on 'Promoções'
      click_on promotion.name
      click_on 'ABC10-0001'
      click_on 'Inativar cupom'

      expect(page).to have_content('Status: Inativo')
      expect(promotion.coupons.reload.active.size).to eq(0)
      expect(promotion.coupons.inactive.size).to eq(1)

   end

   scenario 'and activates coupon again' do

      user = create(:user)
      login_as user, scope: :user
      promotion = create(:promotion, name: 'ABC', user: user)
      inactive_coupon = Coupon.create!(code: 'GHI10-0001', promotion: promotion, status: :inactive)
      active_coupon = Coupon.create!(code: 'GHI10-0002', promotion: promotion)

      visit root_path
      click_on 'Promoções'
      click_on promotion.name
      click_on 'GHI10-0001'
      click_on 'Ativar cupom novamente'
      
      expect(page).to have_link 'Inativar cupom'

   end

end