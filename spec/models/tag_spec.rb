require 'rails_helper'

RSpec.describe Tag, type: :model do
  context '#valid?' do
    it 'nome não pode ficar em branco' do
      tag = Tag.new

      tag.valid?

      expect(tag.errors[:name]).to include('não pode ficar em branco')
    end

    it 'nome deve ser único' do
      Tag.create!(name: 'Ruby')
      tag = Tag.new(name: 'Ruby')

      tag.valid?

      expect(tag.errors[:name]).to include('já está em uso')
    end
  end
end
