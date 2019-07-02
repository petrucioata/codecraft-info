# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Position, type: :model do
  subject(:position) { described_class.new(short_name: short_name, long_name: long_name) }

  context 'when required properties are missing' do
    let(:short_name) { nil }
    let(:long_name) { nil }

    it { expect(position).not_to be_valid }
  end

  context 'when required properties are provided' do
    let(:short_name) { 'SDE test' }
    let(:long_name) { 'Software Development Engineer test' }

    it { expect(position).to be_valid }
  end
end
