require 'rest-client'
require 'json'
require 'date'

class Loader
  def createGame gameday, home_time, original_date, day, home_team_id, away_team_id, status, code, linescore
    r_home = linescore['r']['home']
    r_away = linescore['r']['away']
    if(r_away.to_i > r_home.to_i)
      team_id_win = away_team_id
      team_id_loss = home_team_id
    else
      team_id_win = home_team_id
      team_id_loss = away_team_id
    end
    g = Game.new
    g.gameday = gameday
    g.home_time = home_time
    g.original_date = original_date
    g.day = day
    g.home_team_code =  home_team_id
    g.away_team_code = away_team_id
    g.team_id_win = team_id_win
    g.team_id_loss = team_id_loss
    g.status = status
    g.code = code
    g.save!
    return g
  end

  def createLinescore linescore, game_id, inning
    e_home = linescore['e']['home']
    e_away = linescore['e']['away']
    r_home = linescore['r']['home']
    r_away = linescore['r']['away']
    h_home = linescore['h']['home']
    h_away = linescore['h']['away']
    l = Linescore.new
    l.e_home = e_home
    l.e_away = e_away
    l.r_home = r_home
    l.r_away = r_away
    l.h_home = h_home
    l.h_away = h_away
    l.inning = inning
    l.game_id = game_id
    l.linescore_details = getLinescoreDetails(linescore)
    l.save!
    return l
  end

  def getLinescoreDetails linescore
    array_linescore_details = Array.new
    inning = linescore['inning'].size()
    for i in 0..(inning-1)
      obj = LinescoreDetail.new
      obj.inning = i + 1
      obj.r_away = linescore['inning'][i]['away']
      obj.r_home = linescore['inning'][i]['home']==nil ? 0 : linescore['inning'][i]['home']
      array_linescore_details.push(obj)
    end
    return array_linescore_details
  end

  def createTeam type, name, division, venue, code
    t = Team.find_by(name: name)
    if(type=="H")
      if(t==nil)
        t = Team.new
        t.name = name
        t.code = code
        t.division_id = division.id
        t.venue_id = venue.id
        t.save!
      else
        t.venue_id = venue.id
        t.save
      end
    else
      if(t==nil)
        t = Team.new
        t.name = name
        t.code = code
        t.division_id = division.id
        t.save!
      end
    end
    return t
  end

  def createVenue name
    v = Venue.find_by(name: name)
    if(v==nil)
      v = Venue.new
      v.name = name
      v.save!
    end
    return v
  end

  def createDivision name, league
    d = Division.find_by(name: name, league_id: league.id)
    if(d==nil)
      d = Division.new
      d.name = name
      d.league = league
      d.save!
    end
    return d
  end

  def createLeague code
    l = League.find_by(code: code)
    if(l==nil)
      name = league(code)
      l = League.new
      l.name = name
      l.code = code
      l.save!
    end
    return l
  end

  def createHistoricalDates code
    h = HistoricalDate.where(code: code).exists?(conditions = :none)
    if(!h)
      HistoricalDate.create({code: code})
    end
    return !h
  end

  def league code
    name = ""
    if (code=="104")
      name = "NATIONAL"
    else
      name = "AMERICAN"
    end
    return name
  end

  def processData
    date = Date.new(2007,3,27)
    url = nextDateURL date
    continue = true

    while(continue) do

      if (date.mon==9 && date.mday==9 && date.year==2016)
        continue = false;
        break
      elsif date.mon > 10
        date = Date.new(date.year+1, 3,25)
        url = nextDateURL date
      end

      begin
        response = RestClient.get url
        case response.code
          when 200
            body = JSON.parse(response.body)
            games = body['data']['games']
            id = body['subject']
            if(games['game']==nil ||
              (games['game']!=nil && games['game'].class.to_s=="Hash" && games['game']['game_type']!=nil && games['game']['game_type']=="A") ||
              (games['game']!=nil && games['game'].class.to_s=="Array" && games['game'][0]['game_type']==nil && games['game'][0]['game_type']=="A") )
              date +=1
              url = nextDateURL date
              next
            end
            type_class = games['game'].class.to_s
            if(type_class=="Hash" && games['game']['game_type']=="R")
              continue = createHistoricalDates id
              status = games['game']['status']['status']
              if(status=="Postponed" || status=="In Progress")
                next
              end

              #obtengo data del json
              venue_name = games['game']['venue']
              home_team_name = games['game']['home_team_name']
              away_team_name = games['game']['away_team_name']
              home_team_id = games['game']['home_team_id']
              away_team_id = games['game']['away_team_id']
              home_league_id = games['game']['home_league_id']
              away_league_id = games['game']['away_league_id']
              home_division =  games['game']['home_division']
              away_division =  games['game']['away_division']
              inning = games['game']['status']['inning']
              linescore = games['game']['linescore']
              gameday = games['game']['gameday']
              original_date = games['game']['original_date']
              g_day = games['game']['day']
              home_time = games['game']['home_time']
              game_pk = games['game']['game_pk']

              p "--------------------------BEGIN PROCESS GAME #{game_pk}------------------------------"
              venue = createVenue(venue_name)
              league_home = createLeague(home_league_id)
              league_away = createLeague(away_league_id)
              division_home = createDivision(home_division, league_home)
              division_away = createDivision(away_division, league_away)
              team_home = createTeam("H", home_team_name, division_home, venue, home_team_id)
              team_away = createTeam("A", away_team_name, division_away, venue, away_team_id)
              game = createGame(gameday, home_time, original_date, g_day, home_team_id, away_team_id, status, game_pk, linescore)
              linescore = createLinescore(linescore, game.id, inning)
              p "--------------------------END PROCESS GAME #{game_pk}------------------------------"

            elsif (type_class=="Array" && continue)
              count = games['game'].size() -1
              continue = createHistoricalDates id
              for j in 0..count
                if (games['game'][j]['game_type']=="R")
                  status = games['game'][j]['status']['status']
                  if(status=="Postponed" || status=="In Progress")
                    next
                  end
                  #obtengo data del json
                  venue_name = games['game'][j]['venue']
                  home_team_name = games['game'][j]['home_team_name']
                  away_team_name = games['game'][j]['away_team_name']
                  home_team_id = games['game'][j]['home_team_id']
                  away_team_id = games['game'][j]['away_team_id']
                  home_league_id = games['game'][j]['home_league_id']
                  away_league_id = games['game'][j]['away_league_id']
                  home_division =  games['game'][j]['home_division']
                  away_division =  games['game'][j]['away_division']
                  inning = games['game'][j]['status']['inning']
                  linescore = games['game'][j]['linescore']
                  gameday = games['game'][j]['gameday']
                  original_date = games['game'][j]['original_date']
                  g_day = games['game'][j]['day']
                  home_time = games['game'][j]['home_time']
                  game_pk = games['game'][j]['game_pk']

                  p "--------------------------BEGIN PROCESS GAME #{game_pk}------------------------------"
                  venue = createVenue(venue_name)
                  league_home = createLeague(home_league_id)
                  league_away = createLeague(away_league_id)
                  division_home = createDivision(home_division, league_home)
                  division_away = createDivision(away_division, league_away)
                  team_home = createTeam("H", home_team_name, division_home, venue, home_team_id)
                  team_away = createTeam("A", away_team_name, division_away, venue, away_team_id)
                  game = createGame(gameday, home_time, original_date, g_day, home_team_id, away_team_id, status, game_pk, linescore)
                  linescore = createLinescore(linescore, game.id, inning)
                  p "--------------------------END PROCESS GAME #{game_pk}------------------------------"
                end
              end
            end
            date += 1
            url = nextDateURL date
          when 404
            date += 1
            url = nextDateURL date
        end
    rescue => e
      date += 1
      url = nextDateURL date
    end
    end
  end

  def nextDateURL date
    year = date.year
    month = date.mon
    if(month < 10)
      month = "0"+month.to_s
    end
    day = date.mday
    if(day < 10)
      day = "0"+day.to_s
    end
    url = "http://mlb.com/gdcross/components/game/mlb/year_"+year.to_s+"/month_"+month.to_s+"/day_"+day.to_s+"/master_scoreboard.json"
    return url
  end


end
