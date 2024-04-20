require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'nome não pode ser vazio' do
      user = build(:user, name: '')

      expect(user).not_to be_valid
      expect(user.errors[:name]).to include('não pode ficar em branco')
    end
  end
end
