class LinescoreSerializer < ActiveModel::Serializer
    attributes  :id,
                :inning,
                :r_home,
                :r_away,
                :h_home,
                :h_away,
                :e_home,
                :e_away,
                :game_id,
                :first_inning,
                :total_run_5_inning,
                :linescore_details


    def first_inning
      resp = false
      object.linescore_details.each do |x|
        if (x.inning==1)
          resp = (x.r_home!=0 || x.r_away!=0)
          break
        end
      end
      return resp
    end


    def total_run_5_inning
      sum = 0
      object.linescore_details.each do |x|
        if (x.inning<=5)
          sum += (x.r_home + x.r_away)
          next
        else
          break
        end
      end
      return sum
    end
end
