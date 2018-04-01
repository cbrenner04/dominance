# frozen_string_literal: true

FactoryBot.define do
  factory :score do
    user
    round
    value 1
  end
end
