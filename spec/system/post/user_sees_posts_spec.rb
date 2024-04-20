require 'rails_helper'

describe 'Usuário visualiza publicações' do
  it 'ordenadas por mais recentes' do
    first_post = create(:post)
    second_post = create(:post)
    third_post = create(:post)

    visit root_path

    expect(page).to have_content(third_post.title.truncate(40))
    expect(page).to have_content(third_post.content.truncate(212))
    expect(page).to have_content(third_post.user.name)
    expect(page).to have_content(second_post.title.truncate(40))
    expect(page).to have_content(second_post.content.truncate(212))
    expect(page).to have_content(second_post.user.name)
    expect(page).to have_content(first_post.title.truncate(40))
    expect(page).to have_content(first_post.content.truncate(212))
    expect(page).to have_content(first_post.user.name)

    expect(page.body.index(third_post.title.truncate(40))).to be < page.body.index(second_post.title.truncate(40))
    expect(page.body.index(second_post.title.truncate(40))).to be < page.body.index(first_post.title.truncate(40))
  end

  it 'e vê somente 3 publicações por página' do
    first_post = create(:post)
    second_post = create(:post)
    third_post = create(:post)
    fourth_post = create(:post)
    fifth_post = create(:post)

    visit root_path

    expect(page).to have_content(fifth_post.title.truncate(40))
    expect(page).to have_content(fourth_post.title.truncate(40))
    expect(page).to have_content(third_post.title.truncate(40))
    expect(page).not_to have_content(second_post.title.truncate(40))
    expect(page).not_to have_content(first_post.title.truncate(40))
  end

  it 'e vai para a próxima página' do
    first_post = create(:post)
    second_post = create(:post)
    third_post = create(:post)
    fourth_post = create(:post)
    fifth_post = create(:post)

    visit root_path

    within '.pagination' do
      click_on "2"
    end

    expect(page).to have_content(second_post.title.truncate(40))
    expect(page).to have_content(first_post.title.truncate(40))
    expect(page).not_to have_content(fifth_post.title.truncate(40))
    expect(page).not_to have_content(fourth_post.title.truncate(40))
    expect(page).not_to have_content(third_post.title.truncate(40))
  end

  it 'e volta para a página anterior' do
    first_post = create(:post)
    second_post = create(:post)
    third_post = create(:post)
    fourth_post = create(:post)
    fifth_post = create(:post)

    visit root_path

    within '.pagination' do
      click_on "2"
    end

    within '.pagination' do
      click_on "1"
    end

    expect(page).to have_content(fifth_post.title.truncate(40))
    expect(page).to have_content(fourth_post.title.truncate(40))
    expect(page).to have_content(third_post.title.truncate(40))
    expect(page).not_to have_content(second_post.title.truncate(40))
    expect(page).not_to have_content(first_post.title.truncate(40))
  end

  context 'e clica em uma publicação' do
    it 'e é redirecionado para a página da publicação' do
      post = create(:post)

      visit root_path

      click_on post.title.truncate(40)

      expect(page).to have_content(post.title)
      expect(page).to have_content(post.content)
      expect(page).to have_content(post.user.name)
    end

    it 'e vê os comentários da publicação' do
      post = create(:post)
      comment = create(:comment, post: post)

      visit root_path

      click_on post.title.truncate(40)

      expect(page).to have_content(comment.message)
      expect(page).to have_content(comment.user.name)
    end

    it 'e vê as tags da publicação' do
      post = create(:post)
      tag = create(:tag)
      create(:post_tag, post: post, tag: tag)

      visit root_path

      click_on post.title.truncate(40)

      expect(page).to have_content(tag.name)
    end
  end
end
