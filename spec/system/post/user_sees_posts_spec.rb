require 'rails_helper'

describe 'Usuário visualiza publicações' do
  it 'ordenadas por mais recentes' do
    first_post = create(:post, title: 'Primeira publicação', content: 'Conteúdo da primeira publicação')
    second_post = create(:post, title: 'Segunda publicação', content: 'Conteúdo da segunda publicação')
    third_post = create(:post, title: 'Terceira publicação', content: 'Conteúdo da terceira publicação')

    visit root_path

    expect(page).to have_content(third_post.title)
    expect(page).to have_content(third_post.content)
    expect(page).to have_content(third_post.user.name)
    expect(page).to have_content(second_post.title)
    expect(page).to have_content(second_post.content)
    expect(page).to have_content(second_post.user.name)
    expect(page).to have_content(first_post.title)
    expect(page).to have_content(first_post.content)
    expect(page).to have_content(first_post.user.name)

    expect(page.body.index(third_post.title)).to be < page.body.index(second_post.title)
    expect(page.body.index(second_post.title)).to be < page.body.index(first_post.title)
  end

  it 'e vê somente 3 publicações por página' do
    first_post = create(:post, title: 'Primeira publicação')
    second_post = create(:post, title: 'Segunda publicação')
    third_post = create(:post, title: 'Terceira publicação')
    fourth_post = create(:post, title: 'Quarta publicação')
    fifth_post = create(:post, title: 'Quinta publicação')

    visit root_path

    expect(page).to have_content(fifth_post.title)
    expect(page).to have_content(fourth_post.title)
    expect(page).to have_content(third_post.title)
    expect(page).not_to have_content(second_post.title)
    expect(page).not_to have_content(first_post.title)
  end

  it 'e vai para a próxima página' do
    first_post = create(:post, title: 'Primeira publicação')
    second_post = create(:post, title: 'Segunda publicação')
    third_post = create(:post, title: 'Terceira publicação')
    fourth_post = create(:post, title: 'Quarta publicação')
    fifth_post = create(:post, title: 'Quinta publicação')

    visit root_path

    within '.pagination' do
      click_on '2'
    end

    expect(page).to have_content(second_post.title)
    expect(page).to have_content(first_post.title)
    expect(page).not_to have_content(fifth_post.title)
    expect(page).not_to have_content(fourth_post.title)
    expect(page).not_to have_content(third_post.title)
  end

  it 'e volta para a página anterior' do
    first_post = create(:post, title: 'Primeira publicação')
    second_post = create(:post, title: 'Segunda publicação')
    third_post = create(:post, title: 'Terceira publicação')
    fourth_post = create(:post, title: 'Quarta publicação')
    fifth_post = create(:post, title: 'Quinta publicação')

    visit root_path

    within '.pagination' do
      click_on '2'
    end

    within '.pagination' do
      click_on '1'
    end

    expect(page).to have_content(fifth_post.title)
    expect(page).to have_content(fourth_post.title)
    expect(page).to have_content(third_post.title)
    expect(page).not_to have_content(second_post.title)
    expect(page).not_to have_content(first_post.title)
  end

  context 'clica em uma publicação' do
    it 'e é redirecionado para a página da publicação' do
      post = create(:post)

      visit root_path

      click_on post.title.truncate(40)

      expect(page).to have_content(post.title)
      expect(page).to have_content(post.content)
      expect(page).to have_content(post.user.name)
    end

    it 'e vê os comentários da publicação' do
      post = create(:post, title: '5 dicas para aprender Ruby on Rails')
      comment = create(:comment, post:)

      visit root_path

      click_on post.title

      expect(page).to have_content(comment.message)
      expect(page).to have_content(comment.user.name)
    end

    it 'e vê as tags da publicação' do
      post = create(:post)
      tag = create(:tag)
      create(:post_tag, post:, tag:)

      visit root_path

      click_on post.title.truncate(40)

      expect(page).to have_link(tag.name)
    end
  end

  context 'clica em uma tag' do
    it 'e vê as publicações da tag' do
      first_post = create(:post, title: 'Primeira publicação', content: 'Conteúdo da primeira publicação')
      second_post = create(:post, title: 'Segunda publicação', content: 'Conteúdo da segunda publicação')
      tag = create(:tag, name: 'Ruby')
      create(:post_tag, post: first_post, tag:)
      create(:post_tag, post: second_post, tag:)

      visit root_path
      click_on 'Ruby', match: :first

      expect(page).to have_content(first_post.title)
      expect(page).to have_content(first_post.content)
      expect(page).to have_content(second_post.title)
      expect(page).to have_content(second_post.content)

      expect(page).to have_button('Voltar')
    end

    it 'e não vê publicações sem a tag' do
      first_post = create(:post)
      second_post = create(:post)
      tag = create(:tag, name: 'Ruby')
      create(:post_tag, post: first_post, tag:)

      visit root_path
      click_on 'Ruby'

      expect(page).to have_content(first_post.title.truncate(40))
      expect(page).to have_content(first_post.content.truncate(212))
      expect(page).not_to have_content(second_post.title.truncate(40))
      expect(page).not_to have_content(second_post.content.truncate(212))
    end
  end
end
