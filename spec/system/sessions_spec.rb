require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  context '#Authentication' do
    before do
      User.create(username: 'username', fullname: 'fullname')
    end

    it 'Logs me in' do
      visit '/login'
      fill_in 'username', with: 'username'
      click_button 'Sign in'
      expect(page).to have_content 'Sign In Succesful'
    end

    it 'Fails Login Due to Wrong Username' do
      visit '/login'
      fill_in 'username', with: 'wrong_username'
      click_button 'Sign in'
      expect(page).to have_content 'Login failed'
    end
  end
end
