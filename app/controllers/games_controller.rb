# frozen_string_literal: true

# controller for games
class GamesController < ApplicationController
  def index
    @games = Game.all
    @losers = @games.reverse.map { |game| loser(game) }
    biggest_loser
  end

  def create
    redirect_to(root_path) if Game.create
  end

  def update
    game = Game.find(params[:id])
    redirect_to(root_path) if game.update!(completed_at: Time.zone.now)
  end

  private

  def loser(game)
    chris_score = User.find_by(first_name: 'Chris').total_score(game) || 0
    kristina_score = User.find_by(first_name: 'Kristina').total_score(game) || 0
    score_difference = kristina_score - chris_score
    game_loser = find_the_loser(score_difference)
    difference = score_difference.zero? ? '' : "+#{score_difference.abs}"
    { game: game, loser: game_loser, difference: difference }
  end

  def biggest_loser
    chris_score = User.find_by(first_name: 'Chris').all_time_score || 0
    kristina_score = User.find_by(first_name: 'Kristina').all_time_score || 0
    score_difference = kristina_score - chris_score
    @state_of_the_world = the_state_of_the_world(score_difference)
  end

  def find_the_loser(score_difference)
    if score_difference.zero?
      ''
    elsif score_difference.positive?
      'Kristina'
    else
      'Chris'
    end
  end

  def the_state_of_the_world(score_difference)
    if score_difference.zero?
      ''
    elsif score_difference.positive?
      "Kristina is losing by #{score_difference.abs}"
    else
      "Chris is losing by #{score_difference.abs}"
    end
  end
end
