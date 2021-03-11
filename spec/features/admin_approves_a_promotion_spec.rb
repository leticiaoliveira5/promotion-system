require 'rails_helper'

feature 'Admin approves a promotion' do

  scenario 'and must be signed in' do
    user = create(:user)
    promotion = create(:promotion, user: user)

    visit promotion_path(promotion)
    expect(current_path).to eq new_user_session_path
  end

  scenario 'must not be the promotion creator' do
    creator = create(:user)
    promotion = create(:promotion, user: creator)
    other_user = create(:user, email: 'henrique@email.com')

    login_as creator, scope: :user
    visit promotion_path(promotion)

    expect(page).not_to have_link 'Aprovar Promoção'
  end

  scenario 'must be another user' do
    creator = create(:user)
    promotion = create(:promotion, user: creator)
    other_user = create(:user, email: 'henrique@email.com')

    login_as other_user, scope: :user
    visit promotion_path(promotion)

    expect(page).to have_link 'Aprovar Promoção'
  end

  scenario 'successfully' do
    creator = create(:user)
    promotion = create(:promotion, user: creator)
    approval_user = create(:user, email: 'henrique@email.com')

    login_as approval_user, scope: :user
    visit promotion_path(promotion)
    click_on 'Aprovar Promoção'

    promotion.reload
    expect(current_path).to eq promotion_path(promotion)
    expect(promotion.approved?).to be_truthy
    expect(promotion.approver).to eq approval_user
    expect(page).to have_content("Aprovada por #{approval_user.email}")
  end

end 