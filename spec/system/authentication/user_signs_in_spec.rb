require 'rails_helper'

describe 'Usuário faz login' do
  it 'com sucesso' do
    create(:user, email: 'fulanodetal@email.com', password: '12345678')

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'fulanodetal@email.com'
    fill_in 'Senha', with: '12345678'
    within '.new_user' do
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso.'
  end

  it 'e faz logout' do
    user = create(:user, email: 'fulanodetal@email.com', password: '12345678')

    login_as user
    visit root_path
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
  end
end
