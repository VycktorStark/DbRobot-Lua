return {
  nome = "Fap",
  comandos = {init_cmd..'(boobs)$', init_cmd..'(butts)$', init_cmd..'(fap)$'},
  script = function(msg, bloco)
    local noise = {'.obutts.','.oboobs.'}
    local fap = noise[math.random(#noise)]
    local oboobs = apirequest.Entretenimento.fap.boobs
    local obutts = apirequest.Entretenimento.fap.butts
    if msg.chat.type ~= 'private' then return end
    if bloco[1] == "boobs" then
      local jstr, res = HTTP.request(oboobs)
      if res ~= 200 then end
      local Photo = 'http://media.oboobs.ru/'..JSON.decode(jstr)[1].preview
      api.sendPhoto(msg, Photo)
      return
    end

    if bloco[1] == "butts" then
      local jstr, res = HTTP.request(obutts)
      if res ~= 200 then end
      local Photo = 'http://media.obutts.ru/'..JSON.decode(jstr)[1].preview
      api.sendPhoto(msg, Photo)
      return
    end

    if bloco[1] == "fap" then
      local jstr, res = HTTP.request('http://api'..fap..'ru/noise/1')
      if res ~= 200 then end
      local Photo = 'http://media'..fap..'ru/'..JSON.decode(jstr)[1].preview
      api.sendPhoto(msg, Photo)
      return
    end
  end
}
