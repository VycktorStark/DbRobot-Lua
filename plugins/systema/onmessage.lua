return {
  on_each_msg = function(msg)
    local tr_lang = lang[tr].banhammer
    local spamhash = 'spam:'..msg.chat.id..':'..msg.from.id
    local msgs = tonumber(db:get(spamhash)) or 0
    if msgs == 0 then msgs = 1 end
    local default_spam_value = 5
    if msg.chat.type == 'private' then default_spam_value = 12 end
    local max_msgs = tonumber(db:hget('chat:'..msg.chat.id..':flood', 'MaxFlood')) or default_spam_value
    if msg.cb then max_msgs = 15 end
    local max_time = 5
    db:setex(spamhash, max_time, msgs+1)
    if msgs > max_msgs then
      local status = db:hget('chat:'..msg.chat.id..':settings', 'Flood') or 'yes'
      if status == 'no' and not msg.cb then
        local action = db:hget('chat:'..msg.chat.id..':flood', 'ActionFlood')
        local name = msg.from.first_name
        if msg.from.username then name = name..' (@'..msg.from.username..')' end
        local is_normal_group = false
        local res, message
        if script == 'ban' then
          if msg.chat.type == 'group' then is_normal_group = true end
          res = api.banUser(msg.chat.id, msg.from.id, is_normal_group)
        else
          res = api.kickUser(msg.chat.id, msg.from.id)
        end
        if res then
          if script == 'ban' then
            cross.addBanList(msg.chat.id, msg.from.id, name, tr_lang.banhammer, true)
            message = utils.make_text(tr_lang.flood, name)
          else
            message = utils.make_text(tr_lang.kick, name)
          end
          if msgs == (max_msgs + 1) or msgs == max_msgs + 5 then
            api.sendMessage(msg.chat.id, message, "HTML")
          end
        end
      end

      if msg.cb then
        api.answerCallbackQuery(msg.cb_id, tr_lang.noob_flood)
      end
      return msg, true
    end

    if db:hget('chat:'..msg.chat.id..':settings', 'Rtl') == 'yes' then
      local name = msg.from.first_name
      if msg.from.username then name = name..' (@'..msg.from.username..')' end
      local rtl = '‮'
      local last_name = 'x'
      if msg.from.last_name then last_name = msg.from.last_name end
      local check = msg.text:find(rtl..'+') or msg.from.first_name:find(rtl..'+') or last_name:find(rtl..'+')
      if check ~= nil then
        local res = api.kickUser(msg.chat.id, msg.from.id)
        if res then
          api.sendMessage(utils.make_text(tr_lang.RTL, name), "HTML")
        end
      end
    end

    if msg.text and msg.text:find('([\216-\219][\128-\191])') and db:hget('chat:'..msg.chat.id..':settings', 'Arab') == 'yes' then
      local name = msg.from.first_name
      if msg.from.username then name = name..' (@'..msg.from.username..')' end
      local res = api.kickUser(msg.chat.id, msg.from.id)
      if res then
        api.sendMessage(msg.chat.id, utils.make_text(tr_lang.arabe, name), "HTML")
      end
    end

    return msg
  end
}
