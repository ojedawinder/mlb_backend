class TeamsSerializer < ActiveModel::Serializer
    attributes  :id,
                :name,
                :division_id,
                :venue_id,
                :team_image

    has_one :venue
    has_one :division

end
