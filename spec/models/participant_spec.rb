# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe '.position_name' do
    context 'when the position is known for participant' do
      let!(:participant) { create(:participant) }

      it { expect(participant.position_name).to eq participant.position.short_name }
    end

    context 'when the position is not set' do
      let!(:participant) { create(:participant, position: nil) }

      it { expect(participant.position_name).to eq 'None' }
    end
  end
end
