# frozen_string_literal: true

# user model
class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
         :validatable
  has_many :scores, dependent: :destroy
  validates :first_name, :last_name, presence: true

  def total_score(game)
    scores.where(round: game.rounds.map(&:id)).map(&:value).reduce(:+)
  end

  def all_time_score
    scores.map(&:value).reduce(:+)
  end
end
