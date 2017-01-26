return {
  nome = "Lang",
  comandos = {
    init_cmd..'(lang)$',
    init_botao..'(langselected):(%a%a)$',
    init_cmd..'(lang) (.*)$'
  }, script = function(msg, bloco)
    if msg.chat.type ~= 'private' and not utils.is_mod(msg) then
      if msg.cb then
        api.answerCallbackQuery(msg.cb_id, lang[tr].not_mod:mEscape_hard())
      end
      return
    end
    local keyboard = doKeyboard_lang()
    local selected = bloco[2]

    if bloco[1] == 'lang' and not bloco[2] then
      api.sendKeyboard(msg.chat.id, lang[tr].setlang.list, keyboard, "HTML")
    elseif bloco[1] == 'lang' then
      local new = ''
      selected = selected:gsub("pt", "br")
      for k,v in pairs(config.idioma) do
        if selected == v then
          new = selected
        end
      end
      if new == '' then
        api.sendReply(msg, utils.make_text(lang[tr].setlang.error), "HTML")
      else
        db:set('lang:'..msg.chat.id, new)
        idioma = new:gsub("en","🇺🇸 <code>Ingles(</code><b>en</b><code>)</code>"):gsub("br","🇧🇷 <code>Português(</code><b>br</b><code>)</code>")
        api.sendReply(msg, utils.make_text(lang[tr].setlang.success, idioma), "HTML")
      end
    end

    if bloco[1] == 'langselected' and msg.cb then
      db:set('lang:'..msg.chat.id, selected)
      local selected = selected:gsub("pt", "br")
      idioma = selected:gsub("en","🇺🇸 <code>Ingles(</code><b>en</b><code>)</code>"):gsub("br","🇧🇷 <code>Português(</code><b>br</b><code>)</code>")
      api.editMessageText(msg.chat.id, msg.message_id, utils.make_text(lang[selected].setlang.success, idioma), false, "HTML")
    end
  end
}
