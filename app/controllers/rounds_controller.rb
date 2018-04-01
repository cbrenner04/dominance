# frozen_string_literal: true

# controller for rounds
class RoundsController < ApplicationController
  def index
    @game = Game.find(params[:game_id])
    @rounds = @game.rounds
    @chris_score = User.find_by(first_name: 'Chris').total_score(@game)
    @kristina_score = User.find_by(first_name: 'Kristina').total_score(@game)
  end

  def new
    @game = Game.find(params[:game_id])
    @round = Round.new(game: @game)
    @chris_user = User.find_by(first_name: 'Chris')
    @kristina_user = User.find_by(first_name: 'Kristina')
  end

  def create
    game = Game.find(params[:game_id])
    round = game.rounds.build(name: round_params[:name])
    if round.save && build_scores(round)
      redirect_to(game_rounds_path(game))
    else
      render :new
    end
  end

  private

  def round_params
    params.require(:round).permit(:name, kristina_score: {}, chris_score: {})
  end

  def build_scores(round)
    build_kristina_score(round).save && build_chris_score(round).save
  end

  def build_kristina_score(round)
    round.scores.build(
      user_id: round_params[:kristina_score][:user_id],
      value: round_params[:kristina_score][:value]
    )
  end

  def build_chris_score(round)
    round.scores.build(
      user_id: round_params[:chris_score][:user_id],
      value: round_params[:chris_score][:value]
    )
  end
end
