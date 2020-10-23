require 'rails_helper'

RSpec.describe 'Users', type: :request do
  context '#Controller' do
    it 'Enable to create a new user' do
      get '/users/new'
      assert_response :success
    end
  end
end
