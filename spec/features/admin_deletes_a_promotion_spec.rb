require 'rails_helper'

feature 'admin deletes promotion' do
  scenario 'and is redirected to promotions page' do
    user = create(:user)
    login_as user, scope: :user
    promotion = create(:promotion, name: 'ABC', user: user)

    visit root_path
    click_on 'Promoções'
    click_on 'ABC'
    click_on 'Apagar promoção'

    expect(current_path).to eq(promotions_path)
    expect(page).not_to have_content 'ABC'
  end
end
