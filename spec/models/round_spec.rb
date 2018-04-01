# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Round, type: :model do
  let(:round) { create :round }

  describe 'validations' do
    it { expect(round).to be_valid }

    it 'is invalid without game' do
      round.game = nil

      expect(round).to_not be_valid
    end

    it 'is invalid without name' do
      round.name = nil

      expect(round).to_not be_valid
    end
  end
end
