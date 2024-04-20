require 'rails_helper'

describe 'Usuário cria uma publicação' do
  it 'com sucesso' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'Criar Publicação'
    fill_in 'Título', with: 'Como fazer um Blog do zero'
    fill_in 'Conteúdo', with: 'Primeiro você cria o universo'
    click_on 'Publicar'

    expect(Post.count).to eq 1
    expect(page).to have_current_path post_path(Post.last)
    expect(page).to have_content 'Publicação enviada com sucesso!'
    expect(page).to have_content 'Como fazer um Blog do zero'
    expect(page).to have_content 'Primeiro você cria o universo'
    expect(page).to have_content user.name
  end

  it 'e tenta criar uma publicação vazia' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'Criar Publicação'
    fill_in 'Título', with: ''
    fill_in 'Conteúdo', with: ''
    click_on 'Publicar'

    expect(page).to have_content 'Título não pode ficar em branco'
    expect(page).to have_content 'Conteúdo não pode ficar em branco'
    expect(page).to have_content 'Desculpe, houve um problema ao criar sua publicação. Por favor, tente novamente.'
  end

  it 'e adiciona tags à publicação' do
    user = create(:user)

    login_as user
    visit root_path
    click_on 'Criar Publicação'
    fill_in 'Título', with: 'Como fazer um Blog do zero'
    fill_in 'Conteúdo', with: 'Primeiro você cria o universo'
    fill_in 'Tags', with: 'ruby, rails, blog'
    click_on 'Publicar'

    expect(page).to have_content 'ruby'
    expect(page).to have_content 'rails'
    expect(page).to have_content 'blog'
  end
end
