class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
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
end
