require 'rails_helper'

RSpec.describe Opinion, type: :model do
  let(:user) { User.create(username: 'name', fullname: 'name lastname') }
  context '#Associations' do
    it 'Opinion belongs to an user' do
      association = Opinion.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'Opinion has a user foreign_key' do
      association = Opinion.reflect_on_association(:user)
      expect(association.foreign_key).to eq('user_id')
    end
  end
  context '#Validations' do
    it 'Opinion valid with some text' do
      expect(user.opinions.build(body: 'body text')).to be_valid
    end
    it 'Opinion invalid due empty body' do
      expect(user.opinions.build(body: '')).to_not be_valid
    end
  end
end
