require 'rails_helper'

describe 'Usuário se cadastra' do
  it 'com sucesso' do
    visit root_path
    click_on 'Inscrever-se'
    fill_in 'Nome', with: 'Fulano de Tal'
    fill_in 'E-mail', with: 'fulanodetal@email.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    within 'form' do
      click_on 'Inscrever-se'
    end

    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(User.count).to eq 1
  end
end
