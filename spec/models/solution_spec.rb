# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Solution, type: :model do
  describe 'associations' do
    it { should belong_to(:participation).class_name('Participation') }
    it { should belong_to(:task).class_name('Task') }
  end

  describe 'validations' do
    subject { create(:solution) }

    it { should validate_numericality_of(:points).only_integer }
    it { should validate_uniqueness_of(:participation_id).scoped_to(:task_id) }
  end
end
