require 'rails_helper'

RSpec.describe Tag, type: :model do
  context '#valid?' do
    it 'nome não pode ficar em branco' do
      tag = Tag.new

      tag.valid?

      expect(tag.errors[:name]).to include('não pode ficar em branco')
    end

    it 'nome deve ser único' do
      Tag.create!(name: 'ruby')
      tag = Tag.new(name: 'Ruby')

      tag.valid?

      expect(Tag.count).to eq(1)
      expect(tag.errors[:name]).to include('já está em uso')
    end
  end

  it 'deve ser minúsculo' do
    tag = Tag.new(name: 'Ruby')

    tag.save

    expect(tag.name).to eq('ruby')
  end
end
