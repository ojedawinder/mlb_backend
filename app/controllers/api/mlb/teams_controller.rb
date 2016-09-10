class Api::Mlb::TeamsController < ApplicationController

  # GET /all_teaas/
  def all_teams
    @teams = Team.all
      if @teams.size() > 0
        render json: @teams, each_serializer: TeamsSerializer
      else
        render status: :unprocessable_entity, json: errors_for(@teams)
      end
  end


  #POST /stats_rivals
  def getStatsTeam
    team1 = params[:team1]
    year = params[:year]
    @stats = Game.getStatsRivalsByYear team1, year
    if !@stats.nil?
        render json: @stats, each_serializer: StatsTeamSerializer
    else
        render status: :unprocessable_entity, json: errors_for(@stats)
    end
  end






end
