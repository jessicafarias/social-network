require 'rails_helper'

RSpec.describe 'Users', type: :request do
  context '#Controller' do
    it 'assigns @users' do
      get '/login'
      assert_response :success
    end

    it 'Redirect to users/new' do
      get '/users/new'
      assert_response :success
    end
  end
end
