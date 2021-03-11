require 'rails_helper'

feature 'Admin registers a valid promotion' do
  scenario 'and attributes cannot be blank' do
    user = create(:user)
    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Desconto', with: ''
    fill_in 'Quantidade de cupons', with: ''
    fill_in 'Data de término', with: ''
    click_on 'Criar promoção'

    expect(Promotion.count).to eq 0
    expect(page).to have_content('Não foi possível criar a promoção')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
    expect(page).to have_content('Desconto não pode ficar em branco')
    expect(page).to have_content('Quantidade de cupons não pode ficar em branco')
    expect(page).to have_content('Data de término não pode ficar em branco')
  end

  scenario 'and code must be unique' do
    user = create(:user)
    login_as user, scope: :user
    promotion = create(:promotion, name: 'ABC', user: user)
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    fill_in 'Código', with: 'ABC10'
    click_on 'Criar promoção'

    expect(page).to have_content('Código deve ser único')
  end
end
