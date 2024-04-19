require 'rails_helper'

describe 'Usuário visualiza publicações' do
  it 'ordenadas por mais recentes' do
    first_post = create(:post)
    second_post = create(:post)
    third_post = create(:post)

    visit root_path

    expect(page).to have_content(third_post.title)
    expect(page).to have_content(third_post.content.truncate(212))
    expect(page).to have_content(third_post.user.name)
    expect(page).to have_content(second_post.title)
    expect(page).to have_content(second_post.content.truncate(212))
    expect(page).to have_content(second_post.user.name)
    expect(page).to have_content(first_post.title)
    expect(page).to have_content(first_post.content.truncate(212))
    expect(page).to have_content(first_post.user.name)

    expect(page.body.index(third_post.title)).to be < page.body.index(second_post.title)
    expect(page.body.index(second_post.title)).to be < page.body.index(first_post.title)
  end

  it 'e vê somente 3 publicações por página' do
    first_post = create(:post)
    second_post = create(:post)
    third_post = create(:post)
    fourth_post = create(:post)
    fifth_post = create(:post)

    visit root_path

    expect(page).to have_content(fifth_post.title)
    expect(page).to have_content(fourth_post.title)
    expect(page).to have_content(third_post.title)
    expect(page).not_to have_content(second_post.title)
    expect(page).not_to have_content(first_post.title)
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

    expect(page).to have_content(second_post.title)
    expect(page).to have_content(first_post.title)
    expect(page).not_to have_content(fifth_post.title)
    expect(page).not_to have_content(fourth_post.title)
    expect(page).not_to have_content(third_post.title)
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

    expect(page).to have_content(fifth_post.title)
    expect(page).to have_content(fourth_post.title)
    expect(page).to have_content(third_post.title)
    expect(page).not_to have_content(second_post.title)
    expect(page).not_to have_content(first_post.title)
  end
end
