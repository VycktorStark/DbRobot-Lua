local utils = {}
local cross = {}
local rdb = {}
init_cmd = "^[/#!|]"
init_botao = "^###cb:!"
init_forward = "^###"
msg = msg

function string:input()
  if not self:find(' ') then
    return false
  end
  return self:sub(self:find(' ')+1)
end

function string:trim()
  local s = self:gsub('^%s*(.-)%s*$', '%1')
  return s
end

function string:mEscape_hard()
  self = self:gsub('*', ''):gsub('_', ''):gsub('`', ''):gsub('%[', ''):gsub('%]', '')
  return self
end

function string:TypeChat()
  self = self:gsub('supergroup', 'Super Grupo'):gsub('group', 'Grupo Comum'):gsub('`', ''):gsub('private', 'Chat Privado')
  return self
end

function utils.load_data(filename)
  local f = io.open(filename)
  if not f then
    return {}
  end
  local s = f:read('*all')
  f:close()
  local data = JSON.decode(s)
  return data
end

function utils.CollectStats(msg)
  db:hincrby('bot:general', 'mensagens', 1)
  if msg.from and msg.from.username then
    db:hset('bot:usernames', '@'..msg.from.username:lower(), msg.from.id)
    db:hset('bot:usernames:'..msg.chat.id, '@'..msg.from.username:lower(), msg.from.id)
  end
  if msg.forward_from and msg.forward_from.username then
    db:hset('bot:usernames', '@'..msg.forward_from.username:lower(), msg.forward_from.id)
    db:hset('bot:usernames:'..msg.chat.id, '@'..msg.forward_from.username:lower(), msg.forward_from.id)
  end
  if not(msg.chat.type == 'private') then
    if msg.from.id then
      db:hset('chat:'..msg.chat.id..':userlast', msg.from.id, os.time())
      db:hincrby('chat:'..msg.chat.id..':userstats', msg.from.id, 1)
      if msg.media then
        db:hincrby('chat:'..msg.chat.id..':usermedia', msg.from.id, 1)
      end
    end
    db:incrby('chat:'..msg.chat.id..':totalmsgs', 1)
  end
  if msg.from then
    db:hincrby('user:'..msg.from.id, 'msgs', 1)
    if msg.media then
      db:hincrby('user:'..msg.from.id, 'media', 1)
    end
  end
  if msg.cb and msg.from and msg.chat then
    db:hincrby('chat:'..msg.chat.id..':cb', msg.from.id, 1)
  end
end

function utils.getUserPrint(msg)
  local user = msg.from.first_name
  if msg.from.last_name then
    user = user..' '..msg.from.last_name
  end
  user = cor.reset..cor.blue..' '..cor.cyan..cor.bright..user..cor.reset..cor.red..' (ID: '..msg.from.id..')'
  return user
end

function utils.save_data(filename, data)
  local s = JSON.encode(data)
  local f = io.open(filename, 'w')
  f:write(s)
  f:close()
end

function utils.inline_block(title, text)
  local ran = math.random(1 ,100)
  local inline = '{"type":"article", "id":"'.. ran ..'", "title":"'.. title ..'", "message_text": "'.. text ..'", "parse_mode":"Markdown"}'
  return inline
end

function utils.table_size(tab)
  local i = 0
  for k,v in pairs(tab) do
    i = i + 1
  end
  return i
end

function utils.vardump(value)
  print(serpent.block(value, {comment=false}))
end

function utils.vardumptext(value)
  return serpent.block(value, {comment=false})
end

function utils.write_file(path, text, mode)
  if not mode then
    mode = "w"
  end
  file = io.open(path, mode)
  if not file then
    return false
  else
    file:write(text)
    file:close()
    return true
  end
end

function utils.create_folder(name)
  local cmd = io.popen('sudo mkdir '..name)
  cmd:read('*all')
  cmd = io.popen('sudo chmod -R 777 '..name)
  cmd:read('*all')
  cmd:close()
end

function utils.clone_table(t)
  local new_t = {}
  local i, v = next(t, nil)
  while i do
    new_t[i] = v
    i, v = next(t, i)
  end
  return new_t
end

function utils.get_date(timestamp)
  if not timestamp then
    timestamp = os.time()
  end
  return os.date('%d/%m/%y')
end

voice_updated = 0
voice_succ = 0

function utils.give_result(res)
  if res == 1 then
    voice_succ = voice_succ + 1
    return ' done (res: 1)'
  else
    voice_updated = voice_updated + 1
    return ' updated (res: 0)'
  end
end

function utils.div()
end

function utils.per_away(text)
  local text = tostring(text):gsub('%%', '£&£')
  return text
end

function utils.make_text(text, par1, par2, par3, par4, par5)
  if par1 then text = text:gsub('&&&1', utils.per_away(par1)) end
  if par2 then text = text:gsub('&&&2', utils.per_away(par2)) end
  if par3 then text = text:gsub('&&&3', utils.per_away(par3)) end
  if par4 then text = text:gsub('&&&4', utils.per_away(par4)) end
  if par5 then text = text:gsub('&&&5', utils.per_away(par5)) end
  text = text:gsub('£&£', '%%')
  return text
end

function utils.get_word(s, i)
  s = s or ''
  i = i or 1
  local t = {}
  for w in s:gmatch('%g+') do
    table.insert(t, w)
  end
  return t[i] or false
end

function utils.listCMD()
  local help_comandos = lang[tr].help.titulo
  for k,v in pairs(plugins) do
    if v.nome then
      help_comandos = help_comandos..'<code>'..k..'</code> - <b>'..v.nome..'</b>\n'
    end
  end
  return help_comandos..lang[tr].help.rodape
end

function utils.getVersIA(chat_id)
  local hash = 'chat:'..chat_id..':IADB'
  local ia = db:get(hash)
  if not ia then
    return "1.0"
  else
    return ia
  end
end

function utils.desabilitar_plugin(field, msg)
  local hash = 'chat:'..msg.chat.id..':settings'
  local now = db:hget(hash, field)
  if now == 'yes' then
    api.sendReply(msg, utils.make_text(lang[tr].settings.desabilitado, field), "HTML")
  else
    db:hset(hash, field, 'yes')
    api.sendReply(msg, utils.make_text(lang[tr].settings.desabilitar_plugin, field), "HTML")
  end
end

function utils.habilitar_plugin(field, msg)
  local hash = 'chat:'..msg.chat.id..':settings'
  local now = db:hget(hash, field)
  if now == 'no' then
    api.sendReply(msg, utils.make_text(lang[tr].settings.habilitado, field), "HTML")
  else
    db:hset(hash, field, 'no')
    api.sendReply(msg, utils.make_text(lang[tr].settings.habilitar_plugin, field), "HTML")
  end
end

function utils.getname(msg)
  local nome = msg.from.first_name
  if msg.from.last_name then
    nome = nome..' '..msg.from.last_name
  end
  if msg.from.username then
    nome = '<a href="https://telegram.me/'..msg.from.username..'">'..nome..'</a>'
  end
  return nome
end

function utils.getafk(user_id)
  local hash = user_id', está ausente'
  local afk = db:get(hash)
  if not afk then
    return nil
  else
    return afk
  end
end

function utils.bash(str)
  local cmd = io.popen(str)
  local result = cmd:read('*all')
  cmd:close()
  return result
end

function utils.DownloadFile(url, filename)
  local respbody = {}
  local options = {
    url = url,
    sink = ltn12.sink.table(respbody),
    redirect = true
  }
  local response = nil
  if url:match('^https') then
    options.redirect = false
    response = { HTTPS.request(options) }
  else
    response = { HTTP.request(options) }
  end
  local code = response[2]
  local headers = response[3]
  local status = response[4]
  if code ~= 200 then return false end
  file = io.open(file_path, 'w+')
  file:write(table.concat(respbody))
  file:close()
  return file_path
end

function utils.DownloadLink(res)
  return "https://api.telegram.org/file/bot"..keys.ApiBot.."/"..res.result.file_path
end

function cross.addBanList(chat_id, user_id, nick, why)
  local hash = 'chat:'..chat_id..':bannedlist'
  local res, is_id_added = rdb.set(hash, user_id, 'nick', nick)
  if why and not(why == '') then
    rdb.set(hash, user_id, 'why', why)
  end
  return is_id_added
end

function cross.remBanList(chat_id, user_id)
  if not chat_id or not user_id then return false end
  local hash = 'chat:'..chat_id..':bannedlist'
  local res, des = rdb.rem(hash, user_id)
  return res
end

function cross.saveBan(user_id, motivation)
  local hash = 'ban:'..user_id
  return db:hincrby(hash, motivation, 1)
end

function cross.initGroup(chat_id)
  db:sadd('bot:gruposid', chat_id)
  hash = 'bot:general'
  local num = db:hincrby(hash, 'grupos', 1)
  print('Status: Salvando...', 'Grupos: '..num)
end
function cross.getUserStatus(chat_id, user_id)
  local res = api.getChatMember(chat_id, user_id)
  if res then
    return res.result.status
  else
    return false
  end
end

function rdb.set(hash, id, key, val)
  if not val then
    return false, sudo.campos_em_branco
  else
    local res_sadd = db:sadd(hash, id)
    if res_sadd > 0 then res_sadd = false else res_sadd = true end
    local res_hset = db:hset(hash..':'..id, key, val)
    if res_hset then
      return true, res_sadd, 1
    else
      return true, res_sadd, 0
    end
  end
end

function rdb.get(hash, id, key)
  local res = {}
  local hash_exists = db:exists(hash)
  if not hash_exists then
    return false, sudo.hast_nao_existe
  else
    if key then
      return db:hegt(hahs..':'..id, key)
    else
      if id then
        local hgetall_res = db:hgetall(hash..':'..id)
        if not next(hgetall_res) then
          return false, sudo.hast_sub
        else
          return hgetall_res
        end
      else
        local ids = db:smembers(hash)
        if not next(ids) then
          return false, sudo.campos_em_branco
        else
          for i=1,#ids do
            local hgetall_res = db:hgetall(hash..':'..ids[i])
            if next(hgetall_res) then
              res[ids[i]] = hgetall_res
            end
          end
          return res
        end
      end
    end
  end
end

function rdb.setTable(hash, table)
  if not(type(table) == 'table') then
    return false, sudo.argumento_invalido
  else
    local reset_res = rdb.rem(hash)
    local id_setted = 0
    local kv_setted = 0
    for id,sub_table in pairs(table) do
      id_setted = id_setted + 1
      db:sadd(hash, id)
      for key,val in pairs(sub_table) do
        db:hset(hash..':'..id, key, val)
        kv_setted = kv_setted + 1
      end
    end
    return true, id_setted, kv_setted
  end
end

function rdb.rem(hash, id, key)
  local hash_exists = db:exists(hash)
  if not hash_exists then
    return false, sudo.hast_nao_existe
  else
    local ids = db:smembers(hash)
    if next(ids) then
      if not id then
        local subhash_removed = 0
        for i,id in pairs(ids) do
          db:del(hash..':'..id)
          subhash_removed = subhash_removed + 1
        end
        db:del(hash)
        return true, subhash_removed
      else
        local id_exists = db:sismember(hash, id)
        if not id_exists then
          return false, sudo.campos_em_branco
        else
          if key then
            local res_key = db:hdel(hash..':'..id, key)
            if res_key == 0 then
              return false, sudo.argumento_invalido
            else
              return true
            end
          else
            db:del(hash..':'..id)
            db:srem(hash, id)
            return true, 1
          end
        end
      end
    else
      return false, sudo.campos_em_branco
    end
  end
end

function to_supergroup(msg)
  local old = msg.chat.id
  local new = msg.migrate_to_chat_id
end

function is_blocked(id)
  local hash = 'bloqueando_mensagens'
  return db:sismember(hash, id)
end
function is_locked(msg, cmd)
  local hash = 'chat:'..msg.chat.id..':settings'
  local is_adminmode_locked = db:hget(hash, 'Admin_mode')
  if is_adminmode_locked == 'no' then
    return true
  end
  local current = db:hget(hash, cmd)
  if current == 'yes' then
    return true
  end
  return false
end

function utils.is_banned(chat_id, user_id)
  local hash = 'chat:'..chat_id..':banned'
  local res = db:sismember(hash, user_id)
  if res then
    return true
  else
    return false
  end
end

function utils.handle_exception(msg, err)
  local output = utils.make_text(sudo.handle_exception, err, msg.text, utils.vardumptext(msg.chat.id), utils.vardumptext(msg.chat.type):TypeChat(), utils.vardumptext(msg.chat.title or msg.from.first_name))
  if config.MDChat then
    api.sendLog(output, "Markdown")
  else
    print(output)
  end
end

function utils.match_pattern(pattern, text)
  if text then
    text = text:gsub('@'..bot.username, '')
    local matches = {}
    matches = { string.match(text, pattern) }
    if next(matches) then
      return matches
    end
  end
end

function utils.is_bot_owner(msg, real_owner)
  local id
  if msg.adder and msg.adder.id then
    id = msg.adder.id
  else
    id = msg.from.id
  end
  if real_owner then
    if id == config.admin.owner then
      return true
    end
  else
    if id and config.admin.admins[id] then
      return true
    end
  end
  return false
end

function utils.is_bot_admin(chat_id)
  local status = api.getChatMember(chat_id, bot.id).result.status
  if not(status == 'administrator') then
    return false
  else
    return true
  end
end

function utils.bot_leave(chat_id, chat_title)
  local res = api.leaveChat(chat_id)
  if not res then
    return sudo.sudo.id_error
  else
    db:hincrby('bot:general', 'grupos', -1)
    return utils.make_text(sudo.sudo.saiu, chat_id, chat_title)
  end
end

function utils.is_mod(msg)
  local res = api.getChatMember(msg.chat.id, msg.from.id)
  if not res then
    return false, false
  end
  local status = res.result.status
  if status == 'creator' or status == 'administrator' then
    return true, true
  else
    return false, true
  end
end

function utils.is_mod2(chat_id, user_id)
  local res = api.getChatMember(chat_id, user_id)
  if not res then
    return false, false
  end
  local status = res.result.status
  if status == 'creator' or status == 'administrator' then
    return true, true
  else
    return false, true
  end
end

function utils.is_owner(msg)
  local status = api.getChatMember(msg.chat.id, msg.from.id).result.status
  if status == 'creator' then
    return true
  else
    return false
  end
end

function utils.is_owner2(chat_id, user_id)
  local status = api.getChatMember(chat_id, user_id).result.status
  if status == 'creator' then
    return true
  else
    return false
  end
end

function utils.set_owner(chat_id, user_id, nick)
  db:hset('chat:'..chat_id..':mod', user_id, nick)
  db:hset('chat:'..chat_id..':owner', user_id, nick)
end

return cross, utils, rdb
