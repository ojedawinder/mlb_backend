class LinescoreDetailsSerializer < ActiveModel::Serializer
    attributes  :id,
                :inning,
                :r_home,
                :r_away,
                :linescore_id

end
