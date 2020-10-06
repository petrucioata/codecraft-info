# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Participation, type: :model do
  describe 'associations' do
    it { should belong_to(:participant).class_name('Participant') }
    it { should belong_to(:edition).class_name('Edition') }
    it { should have_many(:solutions).dependent(:nullify) }
  end

  describe 'validations' do
    subject { build(:participation) }

    it { should validate_numericality_of(:total_points).only_integer }
    it { should validate_uniqueness_of(:participant_id).scoped_to(:edition_id) }
  end
end
