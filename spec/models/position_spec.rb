require 'rails_helper'

RSpec.describe Position, type: :model do
  subject(:position) { described_class.new(short_name: short_name, long_name: long_name) }

  context 'when short_name or long_name are missing' do
    let(:short_name) { nil }
    let(:long_name) { nil }

    it 'is invalid without the short_name' do
      expect(subject).to_not be_valid
    end
    it 'is invalid without the long_name' do
      expect(subject).to_not be_valid
    end
  end

  context 'when short_name, long_name are provided' do
    let(:short_name) { 'SDE test' }
    let(:long_name) { 'Software Development Engineer test' }

    it 'is valid with short_name' do
      expect(subject).to be_valid
    end

    it 'is valid with long_name' do
      expect(subject).to be_valid
    end
  end
end
