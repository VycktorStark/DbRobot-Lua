return {
  old = true,
  comandos = {''},
  script = function(msg) -- Crédito ao @Wesley_Henr
    if msg.text == '' then return end
    if msg.text_lower:match('^[Dd][Bb][%p%s](.*)$') then
    elseif msg.text_lower:match('^(.*) [Dd][Bb]$') then
    elseif msg.text_lower:match('^(.*) [Dd][Bb][%p%s](.*)$') then
    elseif msg.text_lower:match('(.*) @[Dd][Bb][Zz][Rr][Oo][Bb][Oo][Tt]$') then
    elseif msg.text_lower:match('(.*) @[Dd][Bb][Zz][Rr][Oo][Bb][Oo][Tt][%p%s]$') then
    elseif msg.text_lower:match('^@[Dd][Bb][Zz][Rr][Oo][Bb][Oo][Tt][%p%s](.*)$') then
    elseif msg.text_lower:match('(.*) @[Dd][Bb][Zz][Rr][Oo][Bb][Oo][Tt][%p%s](.*)$') then
    elseif msg.text_lower:match('^[Dd][Bb]$') then
    elseif msg.text_lower == nil then
    elseif msg.text:match(init_cmd) or msg.text:match(init_botao) then
      return true
    elseif msg.from.id == bot.id then
      return true
    elseif msg.reply_to_message and msg.reply_to_message.from.id == bot.id then
      msg.text_lower = msg.reply_to_message.text
    elseif msg.from.id == msg.chat.id then
    else
      return true
    end
    local input = msg.text_lower
    local url = utils.make_text(apirequest.IA, keys.IA, lang[tr].tr, utils.getVersIA(msg.chat.id)).. URL.escape(input:gsub('db', 'Simsimi'))
    local jstr, res = HTTP.request(url)
    local not_reposta = lang[tr].IA.not_msg
    if res ~= 200 then return end
    local message = JSON.decode(jstr).response
    if not message then
      api.sendMessage(msg.chat.id, not_reposta[math.random(#not_reposta)])
      return
    end
    message = message:gsub('Simsimi', 'Db'):gsub('simsimi', 'Db'):gsub('simsime', 'Dbzin sou eu') :gsub('Simsime', 'Dbzinho sou eu')
    if msg.chat.type == 'private' then
      api.sendChatAction(msg.chat.id, 'typing')
      api.sendReply(msg, message, "HTML")
      return false
    elseif is_locked(msg, 'IA') then
      -- sem resposta
    else
      api.sendChatAction(msg.chat.id, 'typing')
      api.sendReply(msg, message, "HTML")
      return false
    end
    return false
  end
}
