module CalcElo
  def self.calcElo(mmr, rank)
    elo = format_elo(mmr, rank)  
    division = 4 - ((mmr % 1000) / 250).floor
    rp = (mmr % 250)
  
    if elo == "Mythril" || elo == "Titan" || elo == "Immortal"
      return {
        mmr: mmr,
        elo: elo,
        rp: rp,
        format_elo: "#{elo} - RP: #{mmr % 6000}"
      }
    end
  
    return {
      mmr: mmr,
      elo: elo,
      division: division,
      rp: rp,
      format_elo: "#{elo} #{division} - RP: #{rp}"
    }
  end

  def self.format_elo(mmr, rank)
    elo = ""
    if mmr > 0 && mmr < 1000
      elo = "Ferro"
    elsif mmr >= 1000 && mmr < 2000
      elo = "Bronze"
    elsif mmr >= 2000 && mmr < 3000
      elo = "Prata"
    elsif mmr >= 3000 && mmr < 4000
      elo = "Ouro"
    elsif mmr >= 4000 && mmr < 5000
      elo = "Platina"
    elsif mmr >= 5000 && mmr < 6000
      elo = "Diamante"
    elsif mmr >= 6000 && rank > 700
      elo = "Mythril"
    elsif rank >= 201 && rank <= 700
      elo = "Titan"
    elsif rank <= 200
      elo = "Immortal"
    else
      elo = "No Elo"
    end
    return elo
  end
end
