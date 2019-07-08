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
    subject(:create_edition) { post editions_path, params: { edition: params } }

    let(:new_edition) { get new_edition_path }
    let(:params) do
      {
        "name": Faker::App.name,
        "link": Faker::Internet.url('codefights.com'),
        "date": Time.zone.today,
        "description": Faker::Lorem.sentence
      }
    end

    context 'when the required params are provided' do
      it 'renders new Edition view' do
        new_edition
        expect(response).to render_template(:new)
      end

      it { expect { create_edition }.to change(Edition, :count).by(1) }

      it "redirect to the Edition's page" do
        create_edition
        redirect_to(assigns(:edition))
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include('Edition was successfully created.')
      end
    end

    context 'when the required params are missing' do
      let(:params) do
        {
          "name": Faker::App.name,
          "date": Time.zone.today
        }
      end

      it 'renders new Edition view with the corresponding error' do
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

      it 'updates the edition' do
        update_edition
        expect(edition.reload.name).to eq params[:name]
      end

      it "redirects to Edition's page" do
        update_edition
        expect(response).to redirect_to(edition_path(edition))
        follow_redirect!
        expect(response.body).to include('Edition was successfully updated.')
      end
    end

    context 'when some params are incorrect' do
      let(:params) do
        { "name": other_edition.name }
      end

      it 'renders edit Edition view' do
        update_edition
        expect(response).to render_template(:edit)
      end

      it 'returns the corresponding error' do
        update_edition
        expect(response.body).to include('Name has already been taken')
      end
    end
  end

  describe 'deletes an Edition' do
    subject(:delete_edition) { delete edition_path(edition) }

    context 'when the edition is find' do
      it { expect { delete_edition }.to change(Edition, :count).by(-1) }

      it 'redirects to editions list' do
        delete_edition

        expect(response).to redirect_to(editions_path)
      end
    end
  end

  describe 'imports an Edition' do
    subject(:import_edition) do
      post import_edition_path(edition), params: { file: Rack::Test::UploadedFile.new(file) }
    end

    let(:new_import_edition) { get new_import_edition_path(edition) }
    let(:file) { fixture_file_upload(file_name) }

    context 'when the import is successfully made' do
      let(:file_name) { 'well_formatted.csv' }

      it 'renders new import Edition view' do
        new_import_edition
        expect(response).to render_template(:new_import)
      end

      it "redirect to the Edition's page" do
        import_edition
        redirect_to(assigns(:edition))
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include('Edition details were imported.')
      end
    end

    context 'when the edition is not defined' do
      let(:file_name) { 'malformatted.csv' }

      it 'renders new Import Edition view' do
        import_edition

        expect(response).to render_template(:new_import)
      end
    end
  end
end
