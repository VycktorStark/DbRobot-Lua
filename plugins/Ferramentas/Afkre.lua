return {
  nome = "Afkre",
  comandos = {init_cmd.. '([Rr][Ee])$', init_cmd.. '([Aa][Ff][Kk])$', init_cmd.. '([Aa][Ff][Kk]) (.*)$'},
  script = function(msg, bloco)
    if msg.chat.type ~= 'private' then
      local hash = msg.from.id..', está ausente'
      local nome = utils.getname(msg)
      local ausente = db:get(hash)
      if msg.chat.type ~= 'private' then
        if bloco[1] == 're' then
          if not ausente then
          else
            db:del(hash)
            api.sendReply(msg, utils.make_text(lang[tr].afk.on, nome), "HTML")
            return
          end
        end
        if bloco[1] == 'afk' then
          if ausente then
          else
            db:set(hash, 'off')
            if bloco[2] then
              api.sendReply(msg, utils.make_text(lang[tr].afk.off_motivo, nome, bloco[2]), "HTML")
            else
              api.sendReply(msg, utils.make_text(lang[tr].afk.off, nome), "HTML")
            end
            return
          end
        end
      end
    end
  end
}
