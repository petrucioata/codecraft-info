# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:user) { create(:user, password: Faker::Lorem.word) }

  describe 'login a user' do
    let(:params) do
      { 
        email: user.email, 
        password: user.password
      } 
    end

    subject(:login_url) { post "/admin", params: { login: params } }
     
    it 'returns a successful response' do
      login_url
      follow_redirect!

      expect(response.body).to include('Admin was authenticated.')
    end

    it 'renders the root template' do
      login_url
      expect(response).to redirect_to(root_path)
    end
  end
end