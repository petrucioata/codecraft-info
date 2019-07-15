# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  subject(:login_url) { post '/admin', params: { login: params } }

  let!(:user) { create(:user, password: Faker::Lorem.word) }
  let(:params) do
    {
      email: user.email,
      password: user.password
    }
  end

  describe 'login a user' do
    context 'when the credentials are correct' do
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

    context 'when the credentials are incorrect' do
      let(:params) do
        {
          email: user.email,
          password: 'wrong_password'
        }
      end

      it 're-renders the login page' do
        login_url

        expect(response).to render_template(:new)
      end

      it 'displays correct message' do
        login_url

        expect(response.body).to include('Wrong credentials.')
      end
    end
  end

  describe 'logout a user' do
    subject(:logout_url) { delete '/logout', params: { user_id: user.id } }

    before { login_url }

    context 'when the user is logged in' do
      it 'returns a successful response' do
        logout_url
        follow_redirect!

        expect(response.body).to include('Admin was logged out.')
      end

      it 'renders the root template' do
        logout_url

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
