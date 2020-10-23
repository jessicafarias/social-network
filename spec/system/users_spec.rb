require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    User.create(username: 'username', fullname: 'fullname')
  end
  it 'enables me to create a new user' do
    visit '/users/new'
    attach_file('Avatar', "#{Rails.root}/app/assets/images/catrina1.jpg")
    attach_file('Cover image', "#{Rails.root}/app/assets/images/catrina1.jpg")
    fill_in 'Username', with: 'newusername'
    fill_in 'Fullname', with: 'newfullname'
    click_button 'Create account'
    expect(page).to have_content 'User was successfully created please LogIn.'
  end
end
