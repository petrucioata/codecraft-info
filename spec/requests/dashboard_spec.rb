# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  subject(:dashboard) { get root_path }

  context 'when dashboard page is displayed' do
    let!(:position) { create(:position) }
    let!(:edition) { create(:edition, :with_participants, count: 5, position: position) }
    let(:participations) { create_list(:participation, 4, :with_participant, position: position, edition: edition) }

    before { dashboard }

    it { expect(response).to be_successful }
    it { expect(response.body).to include(edition.date.strftime('%b%y')) }
    it { expect(response.body).to include(edition.participants.count.to_s) }
    it { expect(response.body).to include(position.short_name) }
    it { expect(response.body).to include(position.participants.joins(:participations).count.to_s) }
    it { expect(response.body).to include(edition.participants.first.full_name) }
    it { expect(response.body).to include(edition.participations.first.total_points.to_s) }
  end
end
