# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  subject(:dashboard) { get root_path }

  context 'when dashboard page is displayed' do
    let!(:edition) { create(:edition, :with_participants, count: 5) }

    it 'returns a successful response' do
      dashboard

      expect(response).to be_successful
    end

    it 'display edition name and number of participants' do
      dashboard

      expect(edition.participants.count).to eq 5
    end
  end
end
