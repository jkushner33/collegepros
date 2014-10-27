class Player < ActiveRecord::Base

  def self.import_all_players
    players = HTTParty.get('http://www.fantasyfootballnerd.com/service/players/json/mv96pra5v766/').first.last
    players.each do |player|
      if player["active"] == "1"
        Player.create(
          name: player["displayName"],
          last_name: player["lname"],
          first_name: player["fname"],
          team: player["team"],
          position: player["position"],
          school: player["college"],
          nerd_id: player["playerId"]
        )
      end
    end
  end

  def self.school_names
    pluck(:school).uniq.reject(&:empty?)
  end
end
