require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'username is present' do
      user = User.new(email: 'sample@example.com', password: 'foobar').save
      expect(user).to eq(false)
    end

    it 'email presence' do
      user = User.new(username: 'mynamehere', password: 'foobar').save
      expect(user).to eq(false)
    end

    it 'password presence' do
      user = User.new(username: 'mynamehere', email: 'sample@example.com').save
      expect(user).to eq(false)
    end

    it 'should save successfully' do
      user = User.new(username: 'mynamehere', email: 'sample@example.com', password: 'foobar').save
      expect(user).to eq(true)
    end
  end

  context 'scope tests' do
  end
end
