# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:game) { create :game }

  describe 'validations' do
    it { expect(game).to be_valid }
  end
end
