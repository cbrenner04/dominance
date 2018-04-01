# frozen_string_literal: true

# score model
class Score < ApplicationRecord
  belongs_to :user
  belongs_to :round
  validates :user, :round, :value, presence: true
end
