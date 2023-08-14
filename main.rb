require 'webrick'
require 'net/http'
require 'json'
require 'cgi'
require_relative 'calcElo'

class ERConquest < WEBrick::HTTPServlet::AbstractServlet
  CADET_URL = 'https://erconquest.com/casualPlayers.json'
  VETERAN_URL = 'https://erconquest.com/proPlayers.json'

  def do_GET(request, response)
    response['Access-Control-Allow-Origin'] = '*'
    params = request.query_string ? CGI.parse(request.query_string) : {}
    response.body = conquest(params['team']&.first, params['nickname']&.first).to_json
  end

  def conquest(team, nickname)
    response = Net::HTTP.get(select_team(team))
    data = JSON.parse(response)

    if !nickname
      return {
        message: 'Missing nickname.'
      };
    end

    return player(data, nickname.downcase)
  end 

  def select_team(team)
    url = case team
          when "cadet"
            CADET_URL
          else
            VETERAN_URL
          end
    URI(url)
  end

  def player(data, nickname)
    sorted_mmr = data.sort_by { |player| player['mmr'] }.reverse
    result = {}

    sorted_mmr.each_with_index do |player, index|
      if player['name'].downcase == nickname
        result = {
          position: index + 1,
          name: player['name'],
          rank: player['rank'],
          ranked: CalcElo.calcElo(player['mmr'], player['rank']),
          eliminated: player['eliminated']
        }
        break
      else
        result = {
          message: 'Player not found.'
        }
      end
    end
    return result
  end
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount '/', ERConquest

trap('INT') { server.shutdown }
server.start
