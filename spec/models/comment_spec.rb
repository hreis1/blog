require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#valid?' do
    it 'mensagem não pode ficar em branco' do
      comment = build(:comment, message: '')

      expect(comment).not_to be_valid
      expect(comment.errors[:message]).to include('não pode ficar em branco')
    end

    it 'autor é opcional' do
      user = create(:user)
      comment_with_author = build(:comment, user:)
      anonymous_comment = build(:comment, user: nil)

      expect(comment_with_author).to be_valid
      expect(anonymous_comment).to be_valid
    end
  end
end
