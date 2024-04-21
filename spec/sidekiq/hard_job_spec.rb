require 'rails_helper'

RSpec.describe CreatePostsFromTextJob, type: :job do
  describe '#perform' do
    it 'creates a post' do
      user = create(:user)
      text = File.open(Rails.root.join('spec', 'support', 'posts.txt')).read
      expect do
        CreatePostsFromTextJob.new.perform(text, user.id)
      end.to change { Post.count }.by(4)
    end
  end
end
