# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Score, type: :model do
  let(:score) { create :score }

  describe 'validations' do
    it { expect(score).to be_valid }

    it 'is invalid without user' do
      score.user = nil

      expect(score).not_to be_valid
    end

    it 'is invalid without round' do
      score.round = nil

      expect(score).not_to be_valid
    end

    it 'is invalid without value' do
      score.value = nil

      expect(score).not_to be_valid
    end
  end
end
