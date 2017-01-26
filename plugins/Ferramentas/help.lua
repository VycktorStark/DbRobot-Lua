return {
  nome = "Help",
  admin_not_needed = true,
  comandos = {
    init_cmd..'(start)$',
    init_cmd..'(help@'..bot.username..')$',
    init_cmd..'(ajuda@'..bot.username..')$',
    init_cmd..'(help)$',
    init_cmd..'(ajuda)$',
    init_botao..'(dedic)',
    init_botao..'(user)',
    init_botao..'(info_button)',
    init_botao..'(mod)',
    init_botao..'(botao1)',
    init_botao..'(botao2)'},
  script = function(msg, bloco)
    local intro_help = utils.make_text(lang[tr].help.intro,msg.from.first_name)
    local keyboard_private = do_keyboard_private()

    if bloco[1] == 'start' then
      db:hset('bot:users', msg.from.id, 'xx')
      db:hincrby('bot:general', 'users', 1)
      if msg.chat.type == 'private' then
        api.sendKeyboard(msg.from.id, intro_help, keyboard_private, "HTML")
      end
      return
    end

    local keyboard = make_keyboard()
    if bloco[1] == 'ajuda' or bloco[1] == 'help' or bloco[1] == 'ajuda@'..bot.username or bloco[1] == 'help@'..bot.username then
      if not input then
        if msg.chat.type == 'private' then
          api.sendKeyboard(msg.from.id, intro_help, keyboard_private, "HTML")
          return
        end
        local res = api.sendKeyboard(msg.from.id,utils.listCMD(), make_keyboard(), "HTML")
        if res then
          api.sendMessage(msg.chat.id, lang[tr].msg_pv, "HTML")
        else
          api.sendKeyboard(msg.chat.id, lang[tr].nao_start, do_keyboard_startme(), "HTML")
        end
      end
    end
    if msg.cb then
      local query = bloco[1]
      local msg_id = msg.message_id
      local text
      if query == 'dedic' then
        api.editMessageText(msg.chat.id, msg_id, lang[tr].help.dedicando, do_keybaord_dedic(), "HTML")
        return
      end
      if query == 'info_button' then
        api.editMessageText(msg.chat.id, msg_id, utils.make_text(lang[tr].help.version, bot.first_name, config.version), do_keybaord_credits(), "HTML")
        return
      end
      local with_mods_lines = true
      if query == 'user' then
        text = utils.listCMD()
        with_mods_lines = false
      elseif query == 'mod' then
        text = lang[tr].help.mod
      end
      if query == 'botao1' then
        text = [[bloco vazio]]
      elseif query == 'botao2' then
        text = [[bloco vazio]]
      end
      keyboard = make_keyboard(with_mods_lines, query)
      local res, code = api.editMessageText(msg.chat.id, msg_id, text, keyboard, "HTML")
      if not res and code and code == 111 then
        api.answerCallbackQuery(msg.cb_id, lang[tr].help.loopCallback)
      elseif query ~= 'user' and query ~= 'mod' and query ~= 'info_button' then
        api.answerCallbackQuery(msg.cb_id, lang[tr].help.CallbackQuery)
      end
    end
  end
}
