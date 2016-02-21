require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:regular_user) do
    User.create({name: 'Big J', email: 'biggie@devbootcamp.com', password: 'open sesame'})
  end

  describe 'logging in' do
    it 'can access the login form if you are not logged in' do
    end

    it 'logs in with the correct credentials' do
    end

    it 'sends you to the login form if credentials are invalid' do
    end

    it 'cannot access the login form if you are logged in' do
    end
  end

  describe 'logout' do
    it 'removes your user_id from the session if it exists' do
    end
  end

end
