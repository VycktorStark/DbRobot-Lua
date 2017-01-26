return {
  comandos = {init_cmd.."(IA)$",init_cmd.."(IA) (.*)$"},
  script = function (msg, bloco)
    if msg.chat.type == 'private' then end
    if not utils.is_mod(msg) then
      api.sendReply(msg, lang[tr].not_mod, "Markdown")
      return
    end

    local verificar = utils.getVersIA(msg.chat.id)
    local hash = 'chat:'..msg.chat.id..':IADB'
    if bloco[1] == 'IA' then
      if bloco[2] then
        if bloco[2] ~= 'verificar' then
          local reply = nil
          if bloco[2] == 'Normal' or bloco[2] == '1' then
            db:del(hash)
            db:set(hash, '1.0')
            api.sendReply(msg, utils.make_text(lang[tr].IA.alterando, "Normal"), "HTML")
          elseif bloco[2] == 'Sexual' or bloco[2] == '2' then
            db:del(hash)
            db:set(hash, '2.0')
            api.sendReply(msg, utils.make_text(lang[tr].IA.alterando, "Sexual"), "HTML")
          elseif bloco[2] == 'Violento' or bloco[2] == '3' then
            db:del(hash)
            db:set(hash, '3.0')
            api.sendReply(msg, utils.make_text(lang[tr].IA.alterando, "Violento"), "HTML")
          elseif bloco[2] == 'Personalizado' or bloco[2] == '4' then
            db:del(hash)
            db:set(hash, '2.3')
            api.sendReply(msg, utils.make_text(lang[tr].IA.alterando, "Personalizado"), "HTML")
          elseif bloco[2] == 'habilitar' or bloco[2] == 'enable' then
            utils.habilitar_plugin('IA', msg)
          elseif bloco[2] == 'desabilitar' or bloco[2] == 'disable'then
            utils.desabilitar_plugin('IA', msg)
          end
        else
          api.sendReply(msg, verificar, "HTML")
          return
        end
      else
        local HELP = lang[tr].IA.titulo
        for k,v in pairs(lang[tr].IA.help) do
          HELP = HELP..k..v..'\n<code>/IA '
        end
        api.sendReply(msg, utils.make_text(lang[tr].IA.rodape, HELP), "HTML")
        return
      end
    end
  end
}
