require 'rails_helper'

describe 'Usuário edita seu cadastro' do
  it 'altera nome e email' do
    user = create(:user, name: 'Fulano', email: 'fulano@email.com', password: '12345678')

    login_as user
    visit root_path
    click_on 'Fulano'
    click_on 'Editar'
    fill_in 'Nome', with: 'Sicrano'
    fill_in 'E-mail', with: 'sicrano@email.com'
    fill_in 'Senha atual', with: '12345678'
    click_on 'Editar'

    expect(current_path).to eq root_path
    expect(page).to have_content('A sua conta foi atualizada com sucesso.')
    user.reload
    expect(user.name).to eq 'Sicrano'
    expect(user.email).to eq 'sicrano@email.com'
  end

  it 'altera senha' do
    user = create(:user, name: 'Fulano', password: '12345678')

    login_as user
    visit root_path
    click_on 'Fulano'
    click_on 'Editar'
    fill_in 'Senha', with: '87654321'
    fill_in 'Confirme sua senha', with: '87654321'
    fill_in 'Senha atual', with: '12345678'
    click_on 'Editar'

    expect(current_path).to eq root_path
    expect(page).to have_content('A sua conta foi atualizada com sucesso.')
  end

  it 'não altera dados do usuário com dados inválidos' do
    user = create(:user, name: 'Fulano', email: 'fulano@email.com', password: '12345678')

    login_as user
    visit edit_user_registration_path(user)
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Senha atual', with: '12345678'
    click_on 'Editar'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('E-mail não pode ficar em branco')
    expect(user.reload.name).to eq 'Fulano'
    expect(user.reload.email).to eq 'fulano@email.com'
  end

  it 'não altera senha do usuário com senha atual inválida' do
    user = create(:user, name: 'Fulano', password: '12345678')

    login_as user
    visit edit_user_registration_path(user)
    fill_in 'Senha', with: '87654321'
    fill_in 'Confirme sua senha', with: '87654321'
    fill_in 'Senha atual', with: '12345679'
    click_on 'Editar'

    expect(page).to have_content('Senha atual não é válido')
  end

  it 'e esquece a senha atual' do
    user = create(:user, name: 'Fulano', password: '12345678')

    visit new_user_session_path
    click_on 'Esqueceu sua senha?'

    fill_in 'E-mail', with: user.email
    click_on 'Enviar instruções para redefinição da senha'

    expect(page).to have_content('Dentro de minutos, você receberá um e-mail com as instruções de redefinição da sua senha.')
  end
end
