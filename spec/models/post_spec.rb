require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#valid?' do
    it 'título não pode ficar em branco' do
      user = build(:user, name: '')

      expect(user).not_to be_valid
      expect(user.errors[:name]).to include('não pode ficar em branco')
    end

    it 'conteúdo não pode ser vazio' do
      post = build(:post, content: '')

      expect(post).not_to be_valid
      expect(post.errors[:content]).to include('não pode ficar em branco')
    end
  end

  describe '#create_or_delete_post_tags' do
    it 'cria tags para o post' do
      post = create(:post)
      post.create_or_delete_post_tags('tag1, tag2')

      expect(post.tags.count).to eq(2)
    end

    it 'deleta tags do post' do
      post = create(:post)
      post.create_or_delete_post_tags('tag1, tag2')
      post.create_or_delete_post_tags('')

      expect(post.tags.count).to eq(0)
    end
  end
end
