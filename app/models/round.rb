# frozen_string_literal: true

# round model
class Round < ApplicationRecord
  belongs_to :game
  has_many :scores, dependent: :destroy
  validates :game, :name, presence: true
end
