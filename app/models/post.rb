class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags

  validates :title, :content, presence: true

  enum status: { active: 0, deleted: 10 }

  def create_or_delete_post_tags(tags)
    post_tags.destroy_all
    return if tags.blank?
    tags.split(",").each do |tag|
      self.tags << Tag.find_or_create_by(name: tag.strip)
    end
  end

  def self.upload_text_valid?(text)
    return false if text.blank?

    posts = text.split("\n\n")
    posts.each do |post|
      title, content, tags = post.split("\n")
      return false if title.blank?
      return false if content.blank?
    end
    true
  end

  def self.create_from_text(text, user_id)
    posts = text.split("\n\n")
    posts.each do |post|
      title, content, tags = post.split("\n")
      new_post = Post.create(title: title, content: content, user_id: user_id)
      new_post.create_or_delete_post_tags(tags)
    end
  end
end
