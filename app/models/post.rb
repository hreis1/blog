class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, :content, presence: true

  enum status: { active: 0, deleted: 10 }
end
