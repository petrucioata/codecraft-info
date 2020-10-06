# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Position, type: :model do
  describe 'associations' do
    it { should have_many(:participants).dependent(:nullify) }
  end

  describe 'validations' do
    it { should validate_presence_of(:short_name) }
    it { should validate_presence_of(:long_name) }
    it { should validate_uniqueness_of(:short_name) }
  end
end
