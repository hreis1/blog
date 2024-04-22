require 'rails_helper'

describe 'Usuário deleta uma publicação' do
  it 'com sucesso' do
    user = create(:user)
    post = create(:post, user:)

    login_as user
    visit post_path(post)
    click_on 'Excluir'

    expect(page).to have_content('Publicação excluída com sucesso!')
    expect(Post.count).to eq 1
    expect(Post.last.status).to eq 'deleted'
    expect(current_path).to eq(posts_path)
    expect(page).not_to have_content(post.title)
    expect(page).not_to have_content(post.content)
  end

  it 'e não é o autor da publicação' do
    user = create(:user)
    post = create(:post)

    login_as user
    visit post_path(post)

    expect(page).not_to have_link('Excluir')
  end

  it 'e não está logado' do
    post = create(:post)

    visit post_path(post)

    expect(page).not_to have_link('Excluir')
  end
end
