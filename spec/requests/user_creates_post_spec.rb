require 'rails_helper'

describe 'Usuário cria uma publicação' do
  it 'tenta criar com id de outro usuario' do
    user = create(:user)
    other_user = create(:user)

    login_as user
    post posts_path, params: { post: { title: 'Dicas de organização', content: 'Faça uma lista de tarefas e priorize o essencial.', user_id: other_user.id } }

    expect(Post.last.user).to eq user
    expect(response).to redirect_to(post_path(Post.last))
  end

  it 'e não está logado' do
    post posts_path, params: { post: { title: 'Dicas de organização', content: 'Faça uma lista de tarefas e priorize o essencial.' } }

    expect(Post.count).to eq 0
    expect(response).to redirect_to(new_user_session_path)
  end

  it 'tenta acessar formulário de criação sem estar logado' do
    get new_post_path

    expect(response).to redirect_to(new_user_session_path)
  end
end
