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

  describe '.upload_text_valid?' do
    it 'valida o texto do arquivo' do
      file = File.open(Rails.root.join('spec', 'support', 'posts.txt'))
      text = file.read

      expect(Post.upload_text_valid?(text)).to be true
    end

    it 'falso se o texto for vazio' do
      text = ''

      expect(Post.upload_text_valid?(text)).to be false
    end

    it 'falso se título ou conteúdo estiverem em branco' do
      file_blank_title = File.open(Rails.root.join('spec', 'support', 'posts_blank_title.txt'))
      file_blank_content = File.open(Rails.root.join('spec', 'support', 'posts_blank_content.txt'))
      text_blank_title = file_blank_title.read
      text_blank_content = file_blank_content.read

      expect(Post.upload_text_valid?(text_blank_title)).to be false
      expect(Post.upload_text_valid?(text_blank_content)).to be false
    end

    it 'tags são opcionais' do
      file = File.open(Rails.root.join('spec', 'support', 'posts_with_and_without_tags.txt'))
      text = file.read

      expect(Post.upload_text_valid?(text)).to be true
    end

    it 'primeiro post sem tag e segundo post com título em branco' do
      file = File.open(Rails.root.join('spec', 'support', 'posts_first_without_tag_second_blank_title.txt'))
      text = file.read

      expect(Post.upload_text_valid?(text)).to be false
    end
  end

  describe '.create_from_text' do
    it 'cria posts a partir do texto' do
      user = create(:user)
      file = File.open(Rails.root.join('spec', 'support', 'posts.txt'))
      text = file.read
      Post.create_from_text(text, user)

      expect(Post.count).to eq(4)
    end

    it 'cria posts a partir do texto com tags' do
      user = create(:user)
      file = File.open(Rails.root.join('spec', 'support', 'posts_with_and_without_tags.txt'))
      text = file.read
      Post.create_from_text(text, user)

      expect(Post.count).to eq(3)
      expect(Tag.count).to eq(3)
    end
  end
end
