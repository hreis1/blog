require 'rails_helper'

describe 'Usuário edita uma publicação' do
  it 'e não está logado' do
    post = create(:post, title: 'Exercícios matinais', content: 'Comece o dia com alguns alongamentos simples.')

    patch post_path(post), params: { post: { title: 'Dicas de organização', content: 'Faça uma lista de tarefas e priorize o essencial.' } }

    expect(response).to redirect_to(new_user_session_path)
    expect(flash[:alert]).to eq 'Para continuar, faça login ou registre-se.'
  end

  it 'e não consegue editar post de outro usuário' do
    post = create(:post)
    other_user = create(:user)

    login_as other_user
    patch post_path(post), params: { post: { title: 'Dicas de organização', content: 'Faça uma lista de tarefas e priorize o essencial.' } }

    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eq 'Você não tem permissão para acessar esta página.'
  end

  it 'e tenta acessar formulário de edição de outro usuário' do
    post = create(:post)
    other_user = create(:user)

    login_as other_user
    get edit_post_path(post)

    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eq 'Você não tem permissão para acessar esta página.'
  end

  it 'e tenta acessar formulário de edição sem estar logado' do
    post = create(:post)

    get edit_post_path(post)

    expect(response).to redirect_to(new_user_session_path)
    expect(flash[:alert]).to eq 'Para continuar, faça login ou registre-se.'
  end
end