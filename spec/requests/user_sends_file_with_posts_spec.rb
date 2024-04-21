require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers
  describe 'POST #upload' do
    it 'deve estar logado' do
      post :upload

      expect(response).to redirect_to(new_user_session_path)
    end

    it 'envia um arquivo com posts' do
      user = create(:user)

      sign_in user
      file = fixture_file_upload(Rails.root.join('spec', 'support', 'posts.txt'), 'text/plain')
      post :upload, params: { file: file }

      expect(response).to redirect_to(posts_path)
      expect(response.request.flash[:notice]).to eq('Arquivo enviado com sucesso! Processando...')
      expect(Post.count).to eq(4)
    end

    it 'envia um arquivo que não é .txt' do
      user = create(:user)

      sign_in user
      file = fixture_file_upload(Rails.root.join('spec', 'support', 'posts.csv'), 'text/csv')
      post :upload, params: { file: file }

      expect(response).to redirect_to(new_post_path)
      expect(response.request.flash[:alert]).to eq('Desculpe, o arquivo enviado não é válido. Por favor, tente novamente.')
      expect(Post.count).to eq(0)
    end

    it 'e não envia um arquivo' do
      user = create(:user)

      sign_in user
      post :upload

      expect(response).to redirect_to(posts_path)
      expect(response.request.flash[:alert]).to eq(I18n.t("posts.upload.empty"))
      expect(Post.count).to eq(0)
    end

    it 'envia um arquivo com posts inválidos' do
      user = create(:user)

      sign_in user
      file = fixture_file_upload(Rails.root.join('spec', 'support', 'posts_blank_title.txt'), 'text/plain')
      post :upload, params: { file: file }

      expect(response).to redirect_to(new_post_path)
      expect(response.request.flash[:alert]).to eq(I18n.t("posts.upload.invalid"))
      expect(Post.count).to eq(0)
    end
  end
end
