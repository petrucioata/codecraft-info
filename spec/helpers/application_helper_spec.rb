require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#romanian_format' do
    context 'when the date object is provided' do
      let(:date) { Date.new(2020, 01, 01) }
      it { expect(romanian_format(date)).to eq("01 January 2020") }
    end

    context 'when the date is nil' do
      let(:date) { nil }
      it { expect(romanian_format(date)).to eq "" }
    end
  end
end
