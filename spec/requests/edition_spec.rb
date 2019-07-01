# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Editions', type: :request do
  let!(:edition) { create(:edition) }
  let(:other_edition) { create(:edition) }

  describe 'lists all editions' do
    subject(:list_editions) { get editions_path }

    it 'returns a successful response' do
      list_editions
      expect(response).to be_successful
    end

    it 'renders the index template' do
      list_editions
      expect(response).to render_template(:index)
    end
  end

  describe 'creates a new Edition' do
    let(:new_edition) { get new_edition_path }
    let(:params) do
      {
        "name": Faker::App.name,
        "link": Faker::Internet.url('codefights.com'),
        "date": Date.today,
        "description": Faker::Lorem.sentence
      }
    end
    subject(:create_edition) { post editions_path, params: { edition: params } }

    context 'when the required params are provided' do
      it "creates an Edition and redirects to the Edition's page" do
        new_edition
        expect(response).to render_template(:new)

        create_edition
        expect(response).to redirect_to(assigns(:edition))
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include('Edition was successfully created.')
      end
    end

    context 'when the required params are missing' do
      let(:params) do
        {
          "name": Faker::App.name,
          "date": Date.today
        }
      end
      it 'renders new Edition view and returns the corresponding error' do
        create_edition
        expect(response).to render_template(:new)
        expect(response.body).to include('Link can&#39;t be blank')
      end
    end
  end

  describe 'updates an Edition' do
    subject(:update_edition) do
      patch edition_path(edition), params: { edition: params }
    end

    context 'when the params are correct' do
      let(:params) do
        { "name": Faker::App.name }
      end

      it "updates the edition and redirects to Edition's page" do
        update_edition

        expect(response).to redirect_to(edition_path(edition))
        follow_redirect!

        expect(response.body).to include('Edition was successfully updated.')
        expect(edition.reload.name).to eq params[:name]
      end
    end

    context 'when some params are incorrect' do
      let(:params) do
        { "name": other_edition.name }
      end

      it 'renders edit Edition view and returns the corresponding error' do
        update_edition

        expect(response).to render_template(:edit)
        expect(response.body).to include('Name has already been taken')
      end
    end
  end

  describe 'deletes an Edition' do
    subject(:delete_edition) { delete edition_path(edition) }

    context 'when the edition is find' do
      it { expect { delete_edition }.to change { Edition.count }.by(-1) }

      it 'redirects to editions list' do
        delete_edition

        expect(response).to redirect_to(editions_path)
      end
    end
  end
end
