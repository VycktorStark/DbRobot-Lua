return {
  nome = "Repita",
  comandos = {init_cmd..'(repita)$',init_cmd..'(echo)$',init_cmd..'(repita) (.*)$',init_cmd..'(echo) (.*)$'},
  script = function(msg, bloco)
    if bloco[1] == 'repita' or bloco[1] == 'echo' then
      if not bloco[2] then
        api.sendReply(msg, lang[tr].not_repita)
      else
        local res, code = api.sendMessage(msg.chat.id, bloco[2], 'Markdown', false, msg.message_id)
        if not res then
          if code == 118 then
            api.sendMessage(msg.chat.id, lang[tr].bonus.texto_longo)
          else
            api.sendMessage(msg.chat.id, lang[tr].bonus.error_markdown)
          end
        end
      end
    end
  end
}
