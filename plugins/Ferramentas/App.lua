return {
  nome = "StoreApp",
  comandos = {init_cmd..'(1)$',init_cmd..'(2)$'},
  script = function(msg, bloco)
    local nome_dos_apks = {}
    local lista_apks = {
      ["1"] = id_1,
      ["2"] = id_2,
    }
    if bloco[1] == 'arquivos' then
      local text = "*Lista de App's:*"
      for k,v in pairs(nome_dos_apks) do
        text = text..k..' - '..v..'\n'
      end
      api.sendReply(msg, text, "Markdown")
    end
    for k,v in pairs(lista_apks) do
      if bloco[1] == k then
        api.sendDocumentId(msg.chat.id, v, msg.message_id)
      end
    end
  end
}
