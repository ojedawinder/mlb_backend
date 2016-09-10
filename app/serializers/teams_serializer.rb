class TeamsSerializer < ActiveModel::Serializer
    attributes  :code,
                :name,
                :win,
                :loss,
                :away_win,
                :home_win,
                :away_loss,
                :home_loss,
                :division_id,
                :venue_id,
                :team_image

    has_one :venue
    has_one :division

end
