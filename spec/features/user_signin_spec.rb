require 'rails_helper'

feature 'Users sign in' do

    scenario 'successfully' do

        User.create!(email: 'leticia@email.com', password: '123456')

        visit root_path
        click_on 'Entrar'
        within('form') do
        fill_in 'E-mail', with: 'leticia@email.com'
        fill_in 'Senha', with: '123456'
        end
        click_on 'Fazer login'  

        expect(page).to have_content 'Login efetuado com sucesso'
        expect(page).to have_content 'leticia@email.com'
        expect(page).to have_link 'Sair'
        expect(page).not_to have_link 'Entrar'

    end

    scenario 'and log out' do

        user = User.create!(email: 'leticia@email.com', password: '123456')

        visit root_path
        click_on 'Entrar'
        within('form') do
        fill_in 'E-mail', with: 'leticia@email.com'
        fill_in 'Senha', with: '123456'
        click_on 'Fazer login'
        end
        click_on 'Sair'

        expect(page).not_to have_content user.email
        expect(page).not_to have_link 'Sair'
        expect(page).to have_link 'Entrar'
   
    end

end