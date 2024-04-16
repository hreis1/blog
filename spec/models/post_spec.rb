require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'valid?' do
    it 'título não pode ficar em branco' do
      user = build(:user, name: '')

      expect(user).not_to be_valid
      expect(user.errors[:name]).to include('não pode ficar em branco')
    end
  end
end
