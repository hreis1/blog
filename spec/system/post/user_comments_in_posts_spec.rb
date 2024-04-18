require 'rails_helper'

describe 'Usuário comenta publicações' do
  it 'e não está logado' do
    post = create(:post)

    visit root_path
    click_on post.title
    fill_in 'Comentário', with: 'que publicação legal.'
    click_on 'Comentar'

    expect(page).to have_current_path post_path(post)
    expect(page).to have_content 'Comentário enviado com sucesso!'
    expect(page).to have_content 'que publicação legal.'
    expect(page).to have_content 'Anônimo'
  end

  it 'e está logado' do
    user = create(:user)
    post = create(:post)

    login_as user
    visit root_path
    click_on post.title
    fill_in 'Comentário', with: 'que publicação legal.'
    click_on 'Comentar'

    expect(page).to have_current_path post_path(post)
    expect(page).to have_content 'Comentário enviado com sucesso!'
    expect(page).to have_content 'que publicação legal.'
    expect(page).to have_content user.name
  end

  it 'e tenta criar comentário vazio' do
    post = create(:post)

    visit root_path
    click_on post.title
    fill_in 'Comentário', with: ''
    click_on 'Comentar'

    expect(page).to have_content 'Desculpe, não conseguimos enviar seu comentário. Por favor, tente novamente.'
  end
end
