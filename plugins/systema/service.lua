return {
  comandos = {'^###(botadded)','^###(added)','^###(botremoved)','^###(removed)'},
  script = function(msg, bloco)
    if not msg.service then return end
    if bloco[1] == 'botadded' then

      if db:hget('bot:general', 'adminmode') == 'on' and not is_bot_owner(msg) then
        api.sendMessage(msg.chat.id, sudo.admin_on)
        utils.bot_leave(msg.chat.id)
        return
      end
      if is_blocked(msg.adder.id) then
        api.sendMessage(msg.chat.id, sudo.grupoblock, "HTML")
        utils.bot_leave(msg.chat.id)
        return
      end
      cross.initGroup(msg.chat.id)
      api.sendMessage(msg.chat.id, utils.make_text(lang[tr].novoGrupo, msg.adder.username, msg.adder.first_name), "HTML", true)
      api.sendLog(utils.make_text(sudo.addbot, utils.vardumptext(msg.chat),utils.vardumptext(msg.adder)), "HTML")
    end

    if bloco[1] == 'added' then
      if not msg.chat.type == 'private' and utils.is_banned(msg.chat.id, msg.added.id) then
        api.kickChatMember(msg.chat.id, msg.added.id)
        return
      end
      if msg.added.username then
        local username = msg.added.username:lower()
        if username:find('bot', -3) then return end
      end
    end
    if bloco[1] == 'botremoved' then
      db:srem('bot:gruposid', msg.chat.id)
      api.sendLog(utils.make_text(sudo.rembot, utils.vardumptext(msg.chat),utils.vardumptext(msg.adder)), "HTML")

      local num = db:hincrby('bot:general', 'grupos', -1)
      print(cor.blue..cor.bright..sudo.botrem..cor.reset..msg.chat.title..cor.red..sudo.idgrupo..msg.chat.id)
      print(cor.cyan..cor.bright..sudo.savestatus, cor.reset..cor.white..sudo.idgrupo..cor.reset..cor.white..cor.red..num..cor.reset)
    end

    if bloco[1] == 'removed' then
      if msg.remover and msg.removed then
        if msg.remover.id ~= msg.removed.id and msg.remover.id ~= bot.id then
          local action
          if msg.chat.type == 'supergroup' then
            action = 'ban'
          elseif msg.chat.type == 'group' then
            action = 'kick'
          end
          cross.saveBan(msg.removed.id, action)
        end
      end
    end
  end
}
