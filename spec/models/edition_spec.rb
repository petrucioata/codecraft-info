# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Edition, type: :model do
  let(:edition) { create(:edition) }

  describe '.import_csv' do
    before { edition.import_csv(fixture_file_upload(file_name)) }

    context 'when the provided CSV is well formatted' do
      let(:file_name) { 'well_formatted.csv' }
      let(:rows) { CSV.read(fixture_file_upload(file_name), headers: true) }
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

    context 'when the provided CSV is malformatted' do
      let(:file_name) { 'malformatted.csv' }

      it { expect { edition.import_csv }.to raise_error(StandardError) }
    end
  end
end
