# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  subject(:dashboard) { get root_path }

  context 'when dashboard page is displayed' do
    let!(:edition) { create(:edition, :with_participants, count: 5) }

    before { dashboard }

    it { expect(response).to be_successful }
    it { expect(response.body).to include(edition.name) }
    it { expect(response.body).to include(edition.participants.count.to_s) }
  end
end