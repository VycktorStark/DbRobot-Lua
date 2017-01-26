return {
  comandos = {
    init_cmd..'(id)$'
  },
  script = function(msg, bloco)

    if bloco[1] == 'id' then
      if msg.reply_to_message then
        msg = msg.reply_to_message
      end
      local nome = msg.from.first_name
      if msg.from.last_name then
        nome = nome..' '..msg.from.last_name
      end
      if msg.from.username then
        nome = utils.make_text(lang[tr].ID.username, msg.from.username, nome, msg.from.username)
      end
      nome = utils.make_text(lang[tr].ID.nome, nome, msg.from.id)
      if msg.chat.title then
        nome = utils.make_text(lang[tr].ID.grupo, nome, msg.chat.title, msg.chat.id)
      else
        nome = utils.make_text(lang[tr].ID.IDGrupo, nome)
      end
      api.sendReply(msg, nome, "HTML")
    end
  end
}
