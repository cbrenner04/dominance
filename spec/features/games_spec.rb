# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Games', type: :feature do
  let(:chris) { create :user, first_name: 'Chris' }
  let(:kristina) { create :user, first_name: 'Kristina' }
  let(:game_one) do
    create :game, created_at: Time.zone.now - 1.day, completed_at: nil
  end
  let(:game_two) { create :game }
  let(:round_one) { create :round, game: game_one }
  let(:round_two) { create :round, game: game_two }

  before do
    create :score, user: chris, round: round_one, value: 1
    create :score, user: kristina, round: round_one, value: 0
    create :score, user: chris, round: round_two, value: 0
    create :score, user: kristina, round: round_two, value: 1
    log_in_user chris
  end

  # rubocop:disable RSpec/MultipleExpectations
  it 'lists games' do
    expect(page).to have_text "#{game_one.created_at.to_formatted_s(:long)} " \
      '| Not completed | Chris +1'
    expect(page).to have_text "#{game_two.created_at.to_formatted_s(:long)} " \
      "| #{game_two.completed_at.to_formatted_s(:long)} | Kristina +1"
  end
  # rubocop:enable RSpec/MultipleExpectations

  it 'can access a game' do
    click_on game_one.created_at.to_formatted_s(:long)
    expect(page).to have_current_path game_rounds_path(game_one),
                                      ignore_query: true
  end

  context 'when all games are not complete' do
    it 'cannot create game' do
      expect(page).not_to have_text 'Create new game'
    end
  end

  context 'when all games are complete' do
    before do
      game_one.update!(completed_at: Time.zone.now)
      page.refresh
    end

    it 'creates a game' do
      click_on 'Create new game'
      expect(Game.count).to eq 3
    end
  end

  describe 'when the lifetime score is tied' do
    it 'does not display heading' do
      expect(page).not_to have_text 'is losing by'
    end
  end

  describe 'when Chris is the worst' do
    before do
      chris_score_one = Score.find_by(user: chris, round: round_one)
      chris_score_one.update!(value: 3)
      page.refresh
    end

    it 'displays correct heading' do
      expect(page).to have_text 'Chris is losing by 2'
    end
  end

  describe 'when Kristina is the worst' do
    before do
      kristina_score_two = Score.find_by(user: kristina, round: round_two)
      kristina_score_two.update!(value: 3)
      page.refresh
    end

    it 'displays correct heading' do
      expect(page).to have_text 'Kristina is losing by 2'
    end
  end
end
