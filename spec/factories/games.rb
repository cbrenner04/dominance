# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    completed_at { Time.zone.now }
  end
end
