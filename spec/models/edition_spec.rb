# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Edition, type: :model do
  let(:edition) { create(:edition) }

  describe '.import_csv' do
    before { edition.import_csv(fixture_file_upload('well_formatted.csv')) }

    context 'when the provide CSV is well formatted' do
      let(:rows) { CSV.read(fixture_file_upload('well_formatted.csv'), headers: true) }
      let(:usernames) { rows['username'] }
      let(:headers) { %w[nr_crt username task_a task_b task_c points total_time] }

      it { expect(rows.headers).to eq headers }
      it { expect(Task.count).to eq 3 }
      it { expect(Task.all.map(&:name)).to all(include('task_')) }

      it { expect(Participant.count).to eq rows.size }
      it { expect(Participant.all.map(&:username)).to match usernames }

      it { expect(Participation.count).to eq rows.size }
      it { expect(Participation.all.map(&:edition_id)).to all eq edition.id }

      it { expect(Solution.count).to eq rows.size * 3 }
    end
  end
end
