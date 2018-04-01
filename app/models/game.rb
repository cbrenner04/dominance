# frozen_string_literal: true

# game model
class Game < ApplicationRecord
  has_many :rounds, dependent: :destroy
  scope :not_completed, (-> { where(completed_at: nil) })
end
