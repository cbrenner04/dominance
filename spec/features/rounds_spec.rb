# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Rounds', type: :feature do
  before do
    chris = create :user, first_name: 'Chris'
    create :user, first_name: 'Kristina'
    create :game, created_at: Time.zone.now - 1.day, completed_at: nil
    create :game
    log_in_user chris
  end

  context 'when game is not complete' do
    # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
    it 'can create a round' do
      game_one = Game.first
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
    # rubocop:enable RSpec/ExampleLength, RSpec/MultipleExpectations

    # rubocop:disable RSpec/MultipleExpectations
    it 'can complete a round' do
      game_one = Game.first
      expect(page).to have_text 'Not completed'

      visit game_rounds_path(game_one)

      click_on 'Complete game'
      expect(page).to have_no_text 'Not completed'
    end
    # rubocop:enable RSpec/MultipleExpectations
  end

  context 'when game is complete' do
    it 'cannot complete the game' do
      game_two = Game.last
      visit game_rounds_path(game_two)
      expect(page).to have_no_link 'Complete game'
    end

    # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
    it 'can create a round' do
      game_two = Game.last
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
    # rubocop:enable RSpec/ExampleLength, RSpec/MultipleExpectations
  end
end
