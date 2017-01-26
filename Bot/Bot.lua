os.execute('redis-server --daemonize yes') -- créditos ao @Wesley_Henr
os.execute('clear')
HTTP = require('socket.http')
HTTPS = require('ssl.https')
URL = require('socket.url')
JSON = require('Adicional/dkjson')
redis = require('redis')
db = Redis.connect('127.0.0.1', 6379)
db:select(9)
serpent = require('serpent')
cor = require 'term.colors'
cor.wb = cor.onwhite..cor.blue
cor.wr = cor.onwhite..cor.red

bot_init = function(on_reload)

  print(cor.blue..cor.bright..'Carregando configurações...'..cor.cyan..cor.bright)
  erros = dofile('DataConfig/Config-All/Erros.lua')
  config = dofile('DataConfig/Config-All/Config.lua')
  keys = dofile('DataConfig/Config-All/APIs.lua')
  apirequest = dofile('DataConfig/Config-All/APIs.lua').Api
  Plugin = dofile('DataConfig/Config-All/Plugins.lua')
  api = require("Bot/APIResquest")
  cross, utils, rdb = dofile("Bot/Funções.lua")
  lang = require('DataConfig/Lang/Linguaguem')
  desc = require('DataConfig/Lang/desc')
  sudo = require('DataConfig/Lang/Sudo')
  dofile('Adicional/botoes.lua')

  tot = 0
  bot = nil
  while not bot do
    bot = api.getMe()
  end

  bot = bot.result
  plugins = {}
  for k,v in ipairs(Plugin.plugins) do
    local p = dofile('plugins/'..v..'.lua')
    table.insert(plugins, p)
  end

  for k,v in ipairs(Plugin.sudo_plugins) do
    local psudo_plugins = dofile('plugins/'..v..'.lua')
    table.insert(plugins, psudo_plugins)
  end

  local bot_init = sudo.iniciando
  os.execute('figlet Robo Db')
  print(cor.reset..cor.red..'💻 |'..cor.white..cor.bright..bot_init.id_text..cor.blue..cor.bright..bot.id..'\n'..
    cor.green..'✅ |'..cor.white..cor.bright..bot_init.cmd_load..cor.blue..cor.bright..#plugins..
    cor.white..bot_init.PulaLinha..cor.reset)
  if not on_reload then
    textoInit = utils.make_text(bot_init.inicializando, bot.first_name, bot.username, bot.id, #plugins)
    api.sendLog(textoInit, "HTML")
  end
  math.randomseed(os.time())
  math.random()

  last_update = last_update or 0
  last_cron = last_cron or os.time()
  is_started = true
  usernames = usernames or {}
end

on_msg_receive = function(msg)
  if not msg then
    api.sendLog('Merda, um loop sem mensagem!')
    api.sendClean()
    return
  end
  tr = db:get('lang:'..msg.chat.id)
  if not tr then
    tr = 'br'
  end
  if msg.from.username then
    usernames[msg.from.username:lower()] = msg.from.id
  end
  if msg.date < os.time() - 5 then return end
  if not msg.text then msg.text = msg.caption or '' end

  if msg.text:match(init_cmd..'start .+') then
    msg.text = '/' .. msg.text:input()
  end

  if msg.text:match(init_cmd..'start@'..bot.username..' .+') then
    msg.text = '/' .. msg.text:input()
  end

  local Chat_titulo = utils.make_text(sudo.iniciando.enviado, msg.chat.type:TypeChat(), msg.chat.id)

  print('\n'..cor.reset..cor.red..sudo.iniciando.data..cor.reset..utils.getUserPrint(msg)..
    cor.blue..sudo.iniciando.infor_msg..cor.reset..Chat_titulo..
    cor.reset..cor.blue..cor.bright..sudo.iniciando.msg..cor.white..msg.text)
  utils.CollectStats(msg)
  for i,plugin in pairs(plugins) do
    local stop_loop
    if plugin.on_each_msg then
      msg, stop_loop = plugin.on_each_msg(msg)
    end
    if stop_loop then
      break
    else
      if plugin.comandos then
        if is_blocked(msg.from.id) then return end
        if msg.text then
          for k,w in pairs(plugin.comandos) do
            if msg.text and not msg.text_original then
              msg.text_original = msg.text
            end
            local bloco = utils.match_pattern(w, msg.text)
            if plugin.old then
              msg.chat.id_str = tostring(msg.chat.id)
              msg.from.id_str = tostring(msg.from.id)
              msg.text_lower = msg.text:lower()
            end
            if bloco then
              if not(msg.chat.type == 'private') and not db:exists('chat:'..msg.chat.id..':settings') and not msg.service then
              end
              if bloco[1] ~= '' then
                print(cor.reset..cor.cyan..sudo.iniciando.cmd_detectado, cor.reset..cor.red..w..cor.reset)
                db:hincrby('bot:general', 'comandos usados', 1)
                if msg.from then db:incrby('user:'..msg.from.id..':comandos usado', 1) end
              end
              local success, result = pcall(function()
                  return plugin.script(msg, bloco, tr)
                end)
              if not success then
                api.sendReply(msg, sudo.iniciando.msg_error, "HTML")
                utils.handle_exception(msg, result)
                print(msg.text, result)
                return
              end
              if type(result) == 'table' then
                msg = result
              elseif type(result) == 'string' then
                msg.text = result
              elseif result ~= true then
                return
              end
            end
          end
        end
      end
    end
  end
end

local function service_to_message(msg)
  msg.service = true
  if msg.new_chat_member then
    if tonumber(msg.new_chat_member.id) == tonumber(bot.id) then
      msg.text = '###botadded'
    else
      msg.text = '###added'
    end
    msg.adder = utils.clone_table(msg.from)
    msg.added = utils.clone_table(msg.new_chat_member)
  elseif msg.left_chat_member then
    if tonumber(msg.left_chat_member.id) == tonumber(bot.id) then
      msg.text = '###botremoved'
    else
      msg.text = '###removed'
    end
    msg.remover = utils.clone_table(msg.from)
    msg.removed = utils.clone_table(msg.left_chat_member)
  elseif msg.group_chat_created then
    msg.chat_created = true
    msg.adder = utils.clone_table(msg.from)
    msg.text = '###botadded'
  end
  return on_msg_receive(msg)
end

local function forward_to_msg(msg)
  if msg.text then
    msg.text = '###forward:'..msg.text
  else
    msg.text = '###forward'
  end
  return on_msg_receive(msg)
end

local function inline_to_msg(inline)
  local msg = {
    id = inline.id,
    chat = {
      id = inline.id,
      type = 'inline',
      title = inline.from.first_name
    },
    from = inline.from,
    message_id = math.random(1,800),
    text = '###inline:'..inline.query,
    query = inline.query,
    date = os.time() + 100
  }
  db:hincrby('bot:general', 'inline', 1)
  return on_msg_receive(msg)
end

local function media_to_msg(msg)
  if msg.photo then
    msg.text = '###image'
  elseif msg.video then
    msg.text = '###video'
  elseif msg.audio then
    msg.text = '###audio'
  elseif msg.voice then
    msg.text = '###voice'
  elseif msg.document then
    msg.text = '###file'
    if msg.document.mime_type == 'video/mp4' then
      msg.text = '###gif'
    end
  elseif msg.sticker then
    msg.text = '###sticker'
  elseif msg.contact then
    msg.text = '###contact'
  end
  msg.media = true

  if msg.entities then
    for i,entity in pairs(msg.entities) do
      if entity.type == 'url' then
        msg.url = true
        msg.media = true
        break
      end
    end
    if not msg.url then msg.media = false end
  end

  if msg.reply_to_message then
    msg.reply = msg.reply_to_message
  end

  return on_msg_receive(msg)
end

local function rethink_reply(msg)
  msg.reply = msg.reply_to_message
  if msg.reply.caption then
    msg.reply.text = msg.reply.caption
  end
  return on_msg_receive(msg)
end

local function handle_inline_keyboards_cb(msg)
  msg.text = '###cb:'..msg.data
  msg.old_text = msg.message.text
  msg.old_date = msg.message.date
  msg.date = os.time()
  msg.cb = true
  msg.cb_id = msg.id
  msg.message_id = msg.message.message_id
  msg.chat = msg.message.chat
  msg.message = nil
  return on_msg_receive(msg)
end

bot_init()
while is_started do
  local res = api.getUpdates(last_update+1)
  if res then
    for i,msg in ipairs(res.result) do
      last_update = msg.update_id
      tot = tot + 1
      if msg.message or msg.callback_query or msg.edited_message then
        if msg.edited_message then
          msg.message = msg.edited_message
          msg.edited_message = nil
        end
        if msg.callback_query then
          handle_inline_keyboards_cb
          (msg.callback_query)
        elseif msg.message.migrate_to_chat_id then
          to_supergroup(msg.message)
        elseif msg.message.new_chat_member or msg.message.left_chat_member or msg.message.group_chat_created then
          service_to_message(msg.message)
        elseif msg.message.photo or msg.message.video or msg.message.document or msg.message.voice or msg.message.audio or msg.message.sticker or msg.message.entities then
          media_to_msg(msg.message)
        elseif msg.message.forward_from then
          forward_to_msg(msg.message)
        elseif msg.message.reply_to_message then
          rethink_reply(msg.message)
        else
          on_msg_receive(msg.message)
        end
      end
    end
  else
    print(sudo.sudo.error_de_conexao)
  end
  if last_cron ~= os.date('%M') then
    last_cron = os.date('%M')
    for i,v in ipairs(plugins) do
      if v.cron then
        local res, err = pcall(function() v.cron() end)
        if not res then
          return
        end
      end
    end
  end
end

print(sudo.sudo.reiniciando_servidor)
