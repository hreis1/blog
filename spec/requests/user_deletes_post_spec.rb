require 'rails_helper'

describe 'Usuário deleta uma publicação' do
  it 'e não é o autor da publicação' do
    post = create(:post)
    user = create(:user)

    login_as user
    delete post_path(post)

    expect(response).to redirect_to(root_path)
    expect(flash[:alert]).to eq 'Você não tem permissão para acessar esta página.'
  end

  it 'e não está logado' do
    post = create(:post)

    delete post_path(post)

    expect(response).to redirect_to(new_user_session_path)
  end
end
