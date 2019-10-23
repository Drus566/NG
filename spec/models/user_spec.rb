require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures name presence' do
      user = User.new(email: 'sample@mail.ru', password: '123456', password_confirmation: '123456').save
      expect(user).to eq(false)
    end

    it 'ensures email presence' do
      user = User.new(name: 'Andrey', password: '123456', password_confirmation: '123456').save
      expect(user).to eq(false)
    end 

    it 'ensures password presence' do
      user = User.new(name: 'Andrey', email: 'sample@mail.ru').save
      expect(user).to eq(false)
    end

    it 'should save successfully' do
      user = User.new(name: 'Andrey', email: 'sample@mail.ru', password: '123456', password_confirmation: '123456').save
      expect(user).to eq(true)
    end
  end

end
