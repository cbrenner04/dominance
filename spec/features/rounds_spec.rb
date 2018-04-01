# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Rounds' do
  let(:chris) { create :user, first_name: 'Chris' }
  let!(:kristina) { create :user, first_name: 'Kristina' }
  let!(:game_one) do
    create :game, created_at: Time.zone.now - 1.day, completed_at: nil
  end
  let!(:game_two) { create :game }

  before do
    log_in_user chris
  end

  context 'when game is not complete' do
    it 'can create a round' do
      visit game_rounds_path(game_one)

      kristina_score = 10
      chris_score = 12

      click_on 'Create round'
      fill_in 'Round name', with: 'Foo'
      fill_in 'Score for Kristina', with: kristina_score
      fill_in 'Score for Chris', with: chris_score
      click_on 'Save'
      expect(page)
        .to have_text "Kristina: #{kristina_score} | Chris: #{chris_score}"
      expect(page)
        .to have_text "Foo - Kristina: #{kristina_score} Chris: #{chris_score}"

      visit root_path
      expect(page).to have_text 'Chris is losing by 2'
    end

    it 'can complete a round' do
      expect(page).to have_text 'Not completed'

      visit game_rounds_path(game_one)

      click_on 'Complete game'
      expect(page).to have_no_text 'Not completed'
    end
  end

  context 'when game is complete' do
    it 'cannot complete the game' do
      visit game_rounds_path(game_two)
      expect(page).to have_no_link 'Complete game'
    end

    it 'can create a round' do
      visit game_rounds_path(game_two)

      kristina_score = 10
      chris_score = 12

      click_on 'Create round'
      fill_in 'Round name', with: 'Foo'
      fill_in 'Score for Kristina', with: kristina_score
      fill_in 'Score for Chris', with: chris_score
      click_on 'Save'
      expect(page)
        .to have_text "Kristina: #{kristina_score} | Chris: #{chris_score}"
      expect(page)
        .to have_text "Foo - Kristina: #{kristina_score} Chris: #{chris_score}"

      visit root_path
      expect(page).to have_text 'Chris is losing by 2'
    end
  end
end
