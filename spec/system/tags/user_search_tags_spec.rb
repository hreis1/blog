require 'rails_helper'

describe 'Usuário busca por Tag' do
  it 'e encontra posts com a tag' do
    user = create(:user)
    tag = create(:tag, name: 'ruby')
    create(:post, title: 'Post com tag', user:, tags: [tag])
    create(:post, title: 'Post sem tag', user:)

    login_as user
    visit root_path
    fill_in 'Pesquisar...', with: 'ruby'
    find('.search-button').click

    expect(page).to have_content('Post com tag')
    expect(page).not_to have_content('Post sem tag')
  end

  it 'e não encontra Tag' do
    user = create(:user)

    login_as user
    visit root_path
    fill_in 'Pesquisar...', with: 'ruby'
    find('.search-button').click

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Nenhuma tag encontrada com o nome ruby')
  end

  it 'e não digita nada' do
    user = create(:user)

    login_as user
    visit root_path
    find('.search-button').click

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Digite o nome de uma tag para pesquisa')
  end

  it 'e pesquisa por tag com post apagado' do
    user = create(:user)
    tag = create(:tag, name: 'ruby')
    post = create(:post, title: 'Post com tag', user:, tags: [tag])
    post.deleted!

    login_as user
    visit root_path
    fill_in 'Pesquisar...', with: 'ruby'
    find('.search-button').click

    expect(page).to have_content('Nenhuma tag encontrada com o nome ruby')
  end

  it 'e pesquisa com letras maiúsculas' do
    user = create(:user)
    tag = create(:tag, name: 'ruby')
    create(:post, title: 'Post com tag', user:, tags: [tag])

    login_as user
    visit root_path
    fill_in 'Pesquisar...', with: 'Ruby'
    find('.search-button').click

    expect(page).to have_content('#ruby')
    expect(page).to have_content('Post com tag')
  end
end
