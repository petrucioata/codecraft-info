require 'rails_helper'

RSpec.describe 'Participant', type: :request do
  let!(:participant) { create(:participant) }

  describe 'list all participants' do
    subject(:list_participants) { get participants_path }

    it 'returns a successful response' do
      list_participants
      expect(response).to be_successful
    end

    it 'renders the index template' do
      list_participants
      expect(response).to render_template(:index)
    end
  end

  describe 'creates a new Participant' do
    let(:new_participant) { get new_participant_path }
    subject(:create_participant) { post participants_path, params: { participant: params } }

    context 'when the required params are provided' do
      let(:params) {
        {
          "username": Faker::App.name,
          "first_name": Faker::Name.first_name,
          "last_name": Faker::Name.last_name,
          "link": Faker::Internet.url("codefights.com")
        }
      }

      it "creates a Participant and redirects to the Participant's page" do
        new_participant
        expect(response).to render_template(:new)

        create_participant
        expect(response).to redirect_to(assigns(:participant))
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include('Participant was succesfully created.')
      end
    end

    xcontext 'when the required params are missing' do
      let(:params) {
        {
          "name": Faker::App.name,
          "date": Date.today
        }
      }
      it 'renders new Edition view and returns the corresponding error' do
        create_participant
        expect(response).to render_template(:new)
        expect(response.body).to include("Link can&#39;t be blank")
      end
    end
  end
end
