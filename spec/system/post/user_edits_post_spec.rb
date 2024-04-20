require 'rails_helper'

describe 'Usuário edita uma publicação' do
  it 'com sucesso' do
    post = create(:post, title: 'Exercícios matinais', content: 'Comece o dia com alguns alongamentos simples.')

    login_as post.user
    visit post_path(post)
    click_on 'Editar'
    fill_in 'Título', with: 'Dicas de organização'
    fill_in 'Conteúdo', with: 'Faça uma lista de tarefas e priorize o essencial.'
    click_on 'Editar'

    expect(page).to have_current_path post_path(post)
    expect(page).to have_content 'Publicação atualizada com sucesso!'
    expect(page).to have_content 'Dicas de organização'
    expect(page).to have_content 'Faça uma lista de tarefas e priorize o essencial.'
    expect(page).not_to have_content 'Exercícios matinais'
    expect(page).not_to have_content 'Comece o dia com alguns alongamentos simples.'
  end

  it 'e não está logado' do
    post = create(:post, title: 'Exercícios matinais', content: 'Comece o dia com alguns alongamentos simples.')

    visit post_path(post)

    expect(page).not_to have_link 'Editar'
  end

  it 'e não consegue editar post de outro usuário' do
    post = create(:post)
    other_user = create(:user)

    login_as other_user
    visit post_path(post)

    expect(page).not_to have_link 'Editar'
  end

  it 'com informações inválidas' do
    post = create(:post, title: 'Exercícios matinais', content: 'Comece o dia com alguns alongamentos simples.')

    login_as post.user
    visit post_path(post)
    click_on 'Editar'
    fill_in 'Título', with: ''
    fill_in 'Conteúdo', with: ''
    click_on 'Editar'

    expect(page).to have_current_path post_path(post)
    expect(page).to have_content 'Desculpe, houve um problema ao atualizar sua publicação. Por favor, tente novamente.'
    expect(page).to have_content 'Título não pode ficar em branco'
    expect(page).to have_content 'Conteúdo não pode ficar em branco'
  end

  it 'e edita as tags' do
    post = create(:post, title: 'Exercícios matinais', content: 'Comece o dia com alguns alongamentos simples.')
    post.tags << create(:tag, name: 'manhã')
    post.tags << create(:tag, name: 'exercício')
    post.save

    login_as post.user
    visit post_path(post)
    click_on 'Editar'
    fill_in 'Tags', with: 'manhã, alongamento'
    click_on 'Editar'

    expect(page).to have_current_path post_path(post)
    expect(page).to have_content 'Publicação atualizada com sucesso!'
    expect(page).to have_content 'manhã'
    expect(page).to have_content 'alongamento'
  end
end
