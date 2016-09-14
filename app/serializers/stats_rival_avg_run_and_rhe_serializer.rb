class StatsRivalAvgRunAndRheSerializer < ActiveModel::Serializer
    attributes  :Total,
                :TOTAL_RHE,
                :home_team,
                :away_team,
                :home_team_code,
                :away_team_code


    def home_team
      Team.find_by(id: object.home_team_code)
    end

    def away_team
      Team.find_by(id: object.away_team_code)
    end

end
