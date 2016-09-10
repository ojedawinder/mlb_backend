class StatsRivalSerializer < ActiveModel::Serializer
    attributes  :id,
                :gameday,
                :day,
                :time,
                :date,
                :home_team_code,
                :away_team_code,
                :Total,
                :r_home,
                :r_away,
                :h_home,
                :h_away,
                :e_home,
                :e_away,
                :home_team,
                :away_team,
                :TOTAL_RHE

    has_one :linescore, each_serializer: LinescoreSerializer

    def home_team
      Team.find_by(id: object.home_team_code)
    end

    def away_team
      Team.find_by(id: object.away_team_code)
    end

end
