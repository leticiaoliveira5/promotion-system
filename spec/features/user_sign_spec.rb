require 'rails_helper'

feature 'User sign in' do

    scenario 'successfully' do

        user = User.create!(email: 'leticia@email.com', password: '123456')

        visit root_path
        click_on 'Entrar'
        within('form') do
        fill_in 'E-mail', with: user.name
        fill_in 'Senha', with: '123456'
        click_on 'Entrar'
        end

        expect(page).to have_content 'Login realizado com sucesso'
        expect(page).to have_content user.email
        expect(page).to have_link 'Sair'

    end

end