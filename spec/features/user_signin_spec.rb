require 'rails_helper'

feature 'Users sign in' do
  scenario 'successfully' do
    user = create(:user)
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'user@email.com'
      fill_in 'Senha', with: '123456'
    end
    click_on 'Fazer login'

    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_content 'user@email.com'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
  end

  scenario 'and log out' do
    user = create(:user)
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'user@email.com'
      fill_in 'Senha', with: '123456'
      click_on 'Fazer login'
    end
    click_on 'Sair'

    expect(page).not_to have_content user.email
    expect(page).not_to have_link 'Sair'
    expect(page).to have_link 'Entrar'
  end
end
