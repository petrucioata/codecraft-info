# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Participant', type: :request do
  let!(:participant) { create(:participant) }
  let(:password) { 'pass123' }
  let!(:user) { create(:user, password: password) }

  describe 'list all participants' do
    subject(:list_participants) { get participants_path }

    before { login(user.email, password) }

    it 'returns a successful response' do
      list_participants
      response.should be_successful
    end

    it 'renders the index template' do
      list_participants
      response.should render_template(:index)
    end
  end

  describe 'get one participant' do
    subject(:show) { get participant_path(params) }

    before { login(user.email, password) }

    context 'when the participant has no participations' do
      let(:params) { participant }

      it 'returns participant data' do
        show
        response.should render_template(:show)
        expect(response.body).not_to include('Editions results')
      end
    end

    context 'when the participant has participations' do
      let(:params) { create(:participant, :with_participations, count: 4) }

      it 'returns the participant and participations' do
        show
        expect(response.body).to include('Editions results')
      end
    end
  end

  describe 'creates a new Participant' do
    subject(:create_participant) do
      post participants_path, params: { participant: params }
    end

    before { login(user.email, password) }

    let(:new_participant) { get new_participant_path }
    let(:params) do
      {
        "username": Faker::App.name,
        "first_name": Faker::Name.first_name,
        "last_name": Faker::Name.last_name,
        "link": Faker::Internet.url(host: 'codefights.com'),
        "position_id": participant.position_id
      }
    end

    context 'when the required params are provided' do
      it "creates a Participant and redirects to the Participant's page" do
        new_participant
        response.should render_template(:new)

        create_participant.should redirect_to(assigns(:participant))
        follow_redirect!

        response.should render_template(:show)
        expect(response.body).to include('Participant was successfully created.')
      end
    end

    context 'when the username is not unique' do
      before { params[:username] = participant.username }

      it 'renders new Edition view and returns the corresponding error' do
        create_participant
        response.should render_template(:new)
        expect(response.body).to include('Username has already been taken')
      end
    end
  end

  describe 'updates a Participant' do
    subject(:update_participant) do
      patch participant_path(participant), params: { participant: params }
    end

    before { login(user.email, password) }

    context 'when the params are correct' do
      let(:params) do
        {
          "username": Faker::Lorem.unique.word,
          "link": Faker::Internet.url
        }
      end

      it "updates the Participant proporties and redirects to Participant's page" do
        update_participant.should redirect_to(participant_path(participant))
        follow_redirect!

        expect(response.body).to include 'Participant was successfully updated'
        expect { participant.reload }
          .to change(participant, :username)
          .to(params[:username])
          .and change(participant, :link)
          .to(params[:link])
      end
    end

    context 'when the username already exists' do
      let(:second_participant) { create(:participant) }
      let(:params) do
        { "username": second_participant.username }
      end

      it 'renders edit participant view and returns the corresponding error' do
        update_participant

        response.should render_template(:edit)
        expect(response.body).to include('Username has already been taken')
      end
    end
  end

  describe 'deletes a Participant' do
    subject(:delete_participant) { delete participant_path(participant) }

    before { login(user.email, password) }

    context 'when the participant is find' do
      it 'sets deleted to true' do
        delete_participant

        expect(participant.reload.deleted).to eq true
      end

      it 'redirects to participants list' do
        delete_participant.should redirect_to(participants_path)
      end
    end
  end
end
