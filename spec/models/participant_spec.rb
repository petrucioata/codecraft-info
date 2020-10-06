# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe 'associations' do
    it { should belong_to(:position).class_name('Position').optional(true) }
    it { should have_many(:participations).dependent(:destroy) }
    it { should have_many(:editions).through(:participations) }
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
  end

  describe '.position_name' do
    context 'when the position is known for participant' do
      let!(:participant) { create(:participant) }

      it { expect(participant.position_name).to eq participant.position.short_name }
    end
  end
end
