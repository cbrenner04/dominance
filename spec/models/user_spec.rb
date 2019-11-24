# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe 'validations' do
    it { expect(user).to be_valid }

    it 'is invalid without email' do
      user.email = nil

      expect(user).not_to be_valid
    end

    it 'is invalid without first_name' do
      user.first_name = nil

      expect(user).not_to be_valid
    end

    it 'is invalid without last_name' do
      user.last_name = nil

      expect(user).not_to be_valid
    end
  end
end
