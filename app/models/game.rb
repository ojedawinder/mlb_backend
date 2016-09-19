class Game < ApplicationRecord
   has_one :linescore
   #belongs_to :home_team, :class_name => 'Team'
   #belongs_to :away_team, :class_name => 'Team'

  def self.getStatsRivalsByYear team1, team2, year
    Game.find_by_sql ['select g.id as "id", g.gameday as "gameday", g.day as "day", g.home_time as "time", g.original_date as "date", g.home_team_code as "home_team_code", g.away_team_code as "away_team_code", (l.r_home + l.r_away) as "Total", l.r_home as "r_home", l.r_away as "r_away", l.h_home as "h_home", l.h_away as "h_away", l.e_home as "e_home", l.e_away as "e_away" , (l.r_home+l.r_away+l.h_home+l.h_away+l.e_home+l.e_away)as "TOTAL_RHE"
                      from games g, linescores l
                      where g.id = l.game_id and
                      ((g.home_team_code = ? and g.away_team_code = ?) or (g.home_team_code = ? and g.away_team_code = ?) ) and
                      extract(year from g.original_date) = ?
                      order by g.gameday desc',team1, team2, team2, team1, year]
  end


  def self.getStatsRivalsSpecificHomeAndAwayByYear team1, team2, year
    Game.find_by_sql ['select g.id as "id", g.gameday as "gameday", g.day as "day", g.home_time as "time", g.original_date as "date", g.home_team_code as "home_team_code", g.away_team_code as "away_team_code",  (l.r_home + l.r_away) as "Total", l.r_home as "r_home", l.r_away as "r_away", l.h_home as "h_home", l.h_away as "h_away", l.e_home as "e_home", l.e_away as "e_away" , (l.r_home+l.r_away+l.h_home+l.h_away+l.e_home+l.e_away)as "TOTAL_RHE"
                      from games g, linescores l
                      where g.id = l.game_id and
                      g.home_team_code = ? and g.away_team_code = ? and
                      extract(year from g.original_date) = ?
                      order by g.gameday desc',team1, team2, year]
  end

  def self.getStatsRivalsAllTime team1, team2
    Game.find_by_sql ['select g.id as "id", g.gameday as "gameday", g.day as "day", g.home_time as "time", g.original_date as "date", g.home_team_code as "home_team_code", g.away_team_code as "away_team_code",  (l.r_home + l.r_away) as "Total", l.r_home as "r_home", l.r_away as "r_away", l.h_home as "h_home", l.h_away as "h_away", l.e_home as "e_home", l.e_away as "e_away" , (l.r_home+l.r_away+l.h_home+l.h_away+l.e_home+l.e_away)as "TOTAL_RHE"
                      from games g, linescores l
                      where g.id = l.game_id and
                      ((g.home_team_code = ? and g.away_team_code = ?) or (g.home_team_code = ? and g.away_team_code = ?) )
                      order by g.gameday desc',team1, team2, team2, team1]
  end


  def self.getStatsRivalsSpecificHomeAndAwayAllTime team1, team2
    Game.find_by_sql ['select g.id as "id", g.gameday as "gameday", g.day as "day", g.home_time as "time", g.original_date as "date", g.home_team_code as "home_team_code", g.away_team_code as "away_team_code",  (l.r_home + l.r_away) as "Total", l.r_home as "r_home", l.r_away as "r_away", l.h_home as "h_home", l.h_away as "h_away", l.e_home as "e_home", l.e_away as "e_away" , (l.r_home+l.r_away+l.h_home+l.h_away+l.e_home+l.e_away)as "TOTAL_RHE"
                      from games g, linescores l
                      where g.id = l.game_id and
                      g.home_team_code = ? and g.away_team_code = ?
                      order by g.gameday desc',team1, team2]
  end

  def self.getStatsRivalsAVGRunAndRHEByYear team1, team2, year
    Game.find_by_sql ['select avg(l.r_home + l.r_away) as "Total", ? as "home_team_code", ? as "away_team_code", avg(l.r_home+l.r_away+l.h_home+l.h_away+l.e_home+l.e_away)as "TOTAL_RHE" from games g, linescores l
                      where g.id = l.game_id and
                      ((g.home_team_code = ? and g.away_team_code = ?) or (g.home_team_code = ? and g.away_team_code = ?) ) and
                      extract(year from g.original_date) = ?',team1, team2, team1, team2, team2, team1, year]

  end

  def self.getStatsRivalsAVGRunAndRHEAllTime team1, team2
    Game.find_by_sql ['select avg(l.r_home + l.r_away) as "Total", ? as "home_team_code", ? as "away_team_code" ,avg(l.r_home+l.r_away+l.h_home+l.h_away+l.e_home+l.e_away)as "TOTAL_RHE" from games g, linescores l
                      where g.id = l.game_id and
                      (g.home_team_code = ? and g.away_team_code = ?) or (g.home_team_code = ? and g.away_team_code = ?)
                       ',team1, team2,team1, team2, team2, team1]

  end

  def self.getStatsRivalsAVGRunAndRHESpecificHomeAndAwayByYear team1, team2, year
    Game.find_by_sql ['select avg(l.r_home + l.r_away) as "Total", avg(l.r_home+l.r_away+l.h_home+l.h_away+l.e_home+l.e_away)as "TOTAL_RHE" from games g, linescores l
                      where g.id = l.game_id and
                      (g.home_team_code = ? and g.away_team_code = ?)  and
                      extract(year from g.original_date) = ?',team1, team2, year]

  end

  def self.getStatsRivalsAVGRunAndRHESpecificHomeAndAwayAllTime team1, team2
    Game.find_by_sql ['select avg(l.r_home + l.r_away) as "Total", avg(l.r_home+l.r_away+l.h_home+l.h_away+l.e_home+l.e_away)as "TOTAL_RHE" from games g, linescores l
                      where g.id = l.game_id and
                      (g.home_team_code = ? and g.away_team_code = ?)
                       ',team1, team2]

  end

end
