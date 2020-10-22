require 'rails_helper'

RSpec.describe User, type: :model do
  context '#Associations' do
    it 'User has_many followers' do
      association = User.reflect_on_association(:followings)
      expect(association.macro).to eq(:has_many)
    end
    it 'User has_many followings' do
      association = User.reflect_on_association(:relationship)
      expect(association.macro).to eq(:has_many)
    end
    it 'User has_many opinions' do
      association = User.reflect_on_association(:opinions)
      expect(association.macro).to eq(:has_many)
    end
  end
  context '#Validations' do
    it 'User valid with all params' do
      expect(User.new(username: 'user', fullname: 'name lastname')).to be_valid
    end
    it 'User invalid due a short username' do
      expect(User.new(username: 'us', fullname: 'name lastname')).to_not be_valid
    end
    it 'User invalid due a short fullname' do
      expect(User.new(username: 'us', fullname: 'name')).to_not be_valid
    end
    it 'User invalid due a nil fullname' do
      expect(User.new(username: 'us', fullname: nil)).to_not be_valid
    end
    it 'User invalid due a nil username' do
      expect(User.new(username: nil, fullname: 'name lastname')).to_not be_valid
    end
  end
end
