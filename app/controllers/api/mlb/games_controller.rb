class Api::Mlb::GamesController < ApplicationController

  # GET /all_games/
  def all_games
    @games = Game.all
      if @games.size() > 0
          render json: @games
      else
        render status: :unprocessable_entity, json: errors_for(@games)
      end
  end


  #POST /stats_rivals_by_year
  def getStatsRivalsByYear
    team1 = params[:team1]
    team2 = params[:team2]
    year = params[:year]
    @stats = Game.getStatsRivalsByYear team1, team2, year
    if !@stats.nil?
        render json: @stats, each_serializer: StatsRivalSerializer
    else
        render status: :unprocessable_entity, json: errors_for(@stats)
    end
  end

  #POST /stats_rivals_all_time
  def getStatsRivalsAllTime
    team1 = params[:team1]
    team2 = params[:team2]
    @stats = Game.getStatsRivalsAllTime team1, team2
    if !@stats.nil?
        render json: @stats, each_serializer: StatsRivalSerializer
    else
        render status: :unprocessable_entity, json: errors_for(@stats)
    end
  end

  #GET/stats_rivals_avg_run_and_rhe_by_year
  def getStatsRivalsAVGRunAndRHEByYear
    team1 = params[:team1]
    team2 = params[:team2]
    year = params[:year]
    @stats = Game.getStatsRivalsAVGRunAndRHEByYear team1, team2, year
    if !@stats.nil?
        render json: @stats, each_serializer: StatsRivalAvgRunAndRheSerializer
    else
        render status: :unprocessable_entity, json: errors_for(@stats)
    end
  end






end
