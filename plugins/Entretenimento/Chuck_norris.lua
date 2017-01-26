return {
  nome = "Chuck Norris",
  comandos = {init_cmd..'([Cc][Hh][Uu][Cc][Kk])$'},
  script = function(msg, bloco)
    if not bloco[2] then
      local jstr, res = HTTP.request(apirequest.Entretenimento.Chuck_norris)
      if res ~= 200 then end
      local output = JSON.decode(jstr).value.joke
      api.sendMessage(msg.chat.id, '<pre> '.. output ..'</pre>', "HTML", true, msg.message_id)
      return
    end
  end
}
