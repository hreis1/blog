require 'rails_helper'

describe 'Usuário visualiza publicações' do
  it 'ordenadas por mais recentes' do
    first_post = create(:post)
    second_post = create(:post)
    third_post = create(:post)

    visit root_path

    expect(page.body.index(third_post.title)).to be < page.body.index(second_post.title)
    expect(page.body.index(second_post.title)).to be < page.body.index(first_post.title)
  end
end
