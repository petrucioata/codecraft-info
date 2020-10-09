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

  describe 'associations' do
    it { should have_many(:participations).dependent(:destroy) }
    it { should have_many(:participants).through(:participations) }
    it { should have_many(:tasks).dependent(:nullify) }
  end

  describe 'validations' do
    subject { build(:edition) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:link) }
    it { should validate_presence_of(:date) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_uniqueness_of(:link) }

    context 'when date is invalid' do
      before { create(:edition, date: Time.zone.today) }

      let(:edition) { build(:edition, date: Time.zone.today) }

      it { edition.should be_invalid }

      it 'raises duplicate date' do
        edition.valid?
        edition.errors.messages[:date].should eq(["can't be duplicated for month and year"])
      end
    end
  end
end
