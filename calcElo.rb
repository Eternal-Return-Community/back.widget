module CalcElo
  def self.calcElo(mmr)
    elo = format_elo(mmr)  
    division = 4 - ((mmr % 1000) / 250).floor
    rp = (mmr % 250)
  
    if elo == "Mythril" || elo == "Titan" || elo == "Immortal"
      return "#{elo} - RP: #{mmr % 6000}"
    end
  
    return {
      mmr: mmr,
      elo: elo,
      division: division,
      rp: rp,
      format_elo: "#{elo} #{division} - RP: #{rp}"
    }
  end

  def self.format_elo(mmr)
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
    elsif mmr >= 6000 && mmr < 7000
      elo = "Titan"
    elsif mmr >= 7000 && mmr < 8000
      elo = "Mythril"
    elsif mmr >= 8000
      elo = "Immortal"
    else
      elo = "No Elo"
    end
    return elo
  end
end