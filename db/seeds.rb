require 'faker'

tags = FactoryBot.create_list(:tag, 10)

10.times do
  post = FactoryBot.create(:post)

  5.times do
    FactoryBot.create(:comment, post: post)
  end
  rand(1..5).times do
    post.tags << tags.sample
  end
end
