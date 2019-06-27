require 'rails_helper'

RSpec.describe 'Editions', type: :request do
  let!(:edition) { create(:edition) }
  let!(:other_edition) { create(:edition) }

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
    subject(:create_edition) { post editions_path, params: { edition: params } }

    context 'when the required params are provided' do
      let(:params) {
        {
          "name": Faker::App.name,
          "link": Faker::Internet.url("codefights.com"),
          "date": Date.today,
          "description": Faker::Lorem.sentence
        }
      }

      it "creates an Edition and redirects to the Edition's page" do
        new_edition
        expect(response).to render_template(:new)

        create_edition
        expect(response).to redirect_to(assigns(:edition))
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include('Edition was succesfully created.')
      end
    end

    context 'when the required params are missing' do
      let(:params) {
        {
          "name": Faker::App.name,
          "date": Date.today
        }
      }
      it 'renders new Edition view and returns the corresponding error' do
        create_edition
        expect(response).to render_template(:new)
        expect(response.body).to include("Link can&#39;t be blank")
      end
    end
  end

  describe 'updates an Edition' do
    subject(:update_path) { patch edition_path(edition), params: { edition: params } }

    context 'when the params are correct' do
      let(:params) {
        { "name": Faker::App.name }
      }

      it "updates the edition and redirects to Edition's page" do
        update_path

        expect(response).to redirect_to(edition_path(edition))
        follow_redirect!

        expect(response.body).to include('Edition was succesfully updated.')
        expect(edition.reload.name).to eq params[:name]
      end
    end

    context 'when some params are incorrect' do
      let(:params) {
        { "name": other_edition.name }
      }

      it 'renders new Edition view and returns the corresponding error' do
        update_path
        expect(response).to render_template(:new)
        expect(response.body).to include("Name has already been taken")
      end
    end
  end

  describe 'deletes an Edition' do
    subject(:delete_edition) { delete edition_path(edition) }

    context 'when the edition is find' do
      it { expect{ delete_edition }.to change{ Edition.count }.by(-1) }

      it 'redirects to editions list' do
        delete_edition

        expect(response).to redirect_to(editions_path)
        follow_redirect!
      end
    end
  end
end
