class StatsRivalSerializer < ActiveModel::Serializer
    attributes  :id,
                :gameday,
                :day,
                :time,
                :date,
                :Total,
                :r_home,
                :r_away,
                :h_home,
                :h_away,
                :e_home,
                :e_away,
                :TOTAL_RHE

    has_one :linescore, each_serializer: LinescoreSerializer

end
