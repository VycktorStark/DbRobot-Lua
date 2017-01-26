return {
  comandos = {
    init_cmd..'(ajuda) (.*)$',
    init_cmd..'(help) (.*)$'},
  script = function(msg, bloco) -- crédito ao @TiagoDanin
    if msg.chat.type ~= 'private' then return end
    local input = bloco[2]
    if input:match('^[%d]*%d$') then
      local numero_do_comando = ''
      local num = 0
      local convert = math.abs(input)
      for i,v in ipairs(plugins) do
        num = num + 1
        if v.nome then
          numero_do_comando = numero_do_comando .. utils.get_word(v.nome, 1) .. ' '
        end
      end
      input = utils.get_word(numero_do_comando, convert)
      if convert > num then
        input = num
      end
    end
    for i,v in ipairs(plugins) do
      nome_do_plugin = v.nome
      if nome_do_plugin and utils.get_word(nome_do_plugin, 1) == input and desc[tr][nome_do_plugin] then
        api.sendReply(msg, utils.make_text(desc[tr].ajuda, nome_do_plugin, desc[tr][nome_do_plugin]), "HTML")
        return
      end
    end
    api.sendReply(msg, desc[tr].not_cmd)
  end
}
