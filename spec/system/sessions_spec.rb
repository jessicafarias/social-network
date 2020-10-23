require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  context '#Authentication' do
    before do
      visit '/users/new'
      attach_file('Avatar', "#{Rails.root}/app/assets/images/catrina1.jpg")
      attach_file('Cover image', "#{Rails.root}/app/assets/images/catrina1.jpg")
      fill_in 'Username', with: 'newusername'
      fill_in 'Fullname', with: 'newfullname'
      click_button 'Create account'
    end

    it 'Logs me in' do
      visit '/login'
      fill_in 'username', with: 'newusername'
      click_button 'Sign in'
      expect(page).to have_content 'Sign In Succesful.'
    end

    it 'Fails Login Due to Wrong Username' do
      visit '/login'
      fill_in 'username', with: 'wrong_username'
      click_button 'Sign in'
      expect(page).to have_content 'Login failed'
    end
  end
end
