require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'valid?' do
    it 'nome não pode ser vazio' do
      post = build(:post, title: '')

      expect(post).not_to be_valid
      expect(post.errors[:title]).to include('não pode ficar em branco')
    end

    it 'conteúdo não pode ser vazio' do
      post = build(:post, content: '')

      expect(post).not_to be_valid
      expect(post.errors[:content]).to include('não pode ficar em branco')
    end
  end
end
