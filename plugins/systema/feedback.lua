return {
  comandos = {
    init_cmd..'(feedback)$',
    init_cmd..'(feedback) (.*)',
    init_cmd..'(suporte)$',
    init_cmd..'(suporte) (.*)'
  },
  script = function(msg, blocks, ln)
    if not (msg.chat.type == 'private') then return end
    if blocks[1] == 'feedback' or blocks[1] == 'suporte' then
      local input = blocks[2]
      local receiver = msg.from.id
      if not input and not msg.reply then
        api.sendMessage(msg.from.id, sudo.sudo.feedback_help, "HTML")
        return
      end
      if msg.reply then
        msg = msg.reply
      end
      api.forwardMessage(config.MDChat, msg.from.id, msg.message_id)
      api.sendMessage(receiver, sudo.sudo.feedback_enviado, "HTML")
    end
  end
}
