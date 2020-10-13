require 'rails_helper'

RSpec.describe Following, type: :model do
  context '#Associations' do
    it 'Following belongs to user' do
      association = Following.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end
  context '#Validations' do
    it 'Following is valid with 2 users' do
      expect(user.opinions.build(body: 'body text')).to be_valid
    end
  end
end
