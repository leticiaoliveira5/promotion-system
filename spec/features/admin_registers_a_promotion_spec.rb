require 'rails_helper'

feature 'Admin registers a promotion' do
  scenario 'from index page' do
    user = create(:user)
    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'

    expect(page).to have_link('Registrar uma promoção', href: new_promotion_path)
  end

  scenario 'successfully' do
    user = create(:user)
    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'

    fill_in 'Nome', with: 'Cyber Monday'
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'
    click_on 'Criar promoção'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('CYBER15')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('90')
    expect(page).to have_link('Voltar')
    expect(page).to have_content("Cadastrada por #{user.email}")
  end

  scenario 'and choose product categories' do
    user = create(:user)
    login_as user, scope: :user

    ProductCategory.create!(name: 'Smartphones', code: 'SMARTPHONE')
    ProductCategory.create!(name: 'Teclados', code: 'KEYBOARD')
    ProductCategory.create!(name: 'Monitores', code: 'DISPLAY')
    ProductCategory.create!(name: 'Mouses', code: 'MOUSE')

    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'

    fill_in 'Nome', with: 'Cyber Monday'
    fill_in 'Descrição', with: 'Promoção de Cyber Monday'
    fill_in 'Código', with: 'CYBER15'
    fill_in 'Desconto', with: '15'
    fill_in 'Quantidade de cupons', with: '90'
    fill_in 'Data de término', with: '22/12/2033'
    check 'Smartphones'
    check 'Teclados'
    check 'Monitores'
    click_on 'Criar promoção'

    expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content('Monitores')
    expect(page).to have_content('Teclados')
    expect(page).to have_content('Smartphones')
  end
end
