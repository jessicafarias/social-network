require 'rails_helper'

RSpec.describe 'UserSessions', type: :request do
  context '#Controller' do

    it 'assigns @users' do
      get '/login'
      assert_response :success
    end

  end
end
