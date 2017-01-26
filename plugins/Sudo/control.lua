local function cron()
  db:bgsave()
end
local Comandos = {
  init_cmd..'(admin)$',
  init_cmd..'(arquivos)$',
  init_cmd..'(atualizar)$',
  init_cmd..'(atualizar grupo)$',
  init_cmd..'(reiniciar)$',
  init_cmd..'(bloq) (%d+)$',
  init_cmd..'(desbloq) (%d+)$',
  init_cmd..'(bloq)$',
  init_cmd..'(desbloq)$',
  init_cmd..'(backup)$',
  init_cmd..'(publicar) (.*)$',
  init_cmd..'(sendGP) (.*)$',
  init_cmd..'(run)$',
  init_cmd..'(run) (.*)$',
  init_cmd..'(git)$',
  init_cmd..'(git) (.*)$',
  init_cmd..'(logs) (del) (.*)',
  init_cmd..'(logs) (del)',
  init_cmd..'(logs) (.*)$',
  init_cmd..'(logs)$',
  init_cmd..'(sair) (-%d+)$',
  init_cmd..'(sair)$',
  init_cmd..'(postar) (.*)$',
  init_cmd..'(enviar) (-?%d+) (.*)$',
  init_cmd..'(enviar) (.*)$',
  init_cmd..'(responder)$',
  init_cmd..'(responder) (.*)$',
  init_cmd..'(users)$',
  init_cmd..'(download)$',
  init_cmd..'(redis)$',
  init_cmd..'(stats)$',
  init_cmd..'(sudo) (remove)$',
  init_cmd..'(req) (.*)$',
  init_cmd..'(salvar)$',
  init_cmd..'(db) (.*)$',
  init_cmd..'pin (delete)$',
  init_cmd..'pin (salvar)$',
  init_cmd..'(pin)$',
  init_cmd..'(code)$',
  init_cmd..'(resetar) (.*)$',
  init_cmd..'(resetar)$',
  init_forward..'(forward)'}
return {
  cron = cron,
  comandos = Comandos,
  script = function(msg, bloco)
    local sudo = sudo.sudo
    local ajuda = sudo.ajuda
    local logs = sudo.logs
    local RD = sudo.redis
    local lang_pt = lang.br
    local servidor = sudo.servidor
    local reiniciando = utils.make_text(servidor, sudo.reiniciando)
    local att = sudo.att
    local publique_sim = sudo.publique_sim
    local markdown_error = sudo.markdown_error
    local sem_id_nao_publicado = sudo.sem_id_nao_publicado
    local publicado = sudo.publicado
    local del_pasta = utils.make_text(servidor, sudo.pasta_del)
    local nao_publique = sudo.nao_publique
    local publicado_em = utils.make_text(sudo.publicado_em, config.canal)
    local logtxt = ''
    local failed = 0
    if bloco[1] == 'forward' then
      if not config.admin.admins[msg.from.id] then return nil end
      if msg.chat.type == 'private' then
        if msg.forward_from then
          api.sendReply(msg, msg.forward_from.id)
        end
      end
      return msg.text:gsub('###forward:', '')
    end
    if not bloco or not next(bloco) then return true end

    if not config.admin.admins[msg.from.id] then
      api.sendReply(msg, sudo.notSudo)
      return
    end
    bloco = {}
    for k,v in pairs(Comandos) do
      bloco = utils.match_pattern(v, msg.text)
      if bloco then break end
    end
    if bloco[1] == 'arquivos' then
      local text = sudo.cabecario_arquivos
      for k,v in pairs(Plugin.plugins) do
        text = text..k..' - '..v..'\n'
      end
      api.sendReply(msg, text, "HTML")
    end

    if bloco[1] == 'admin' then
      local text = sudo.cabecario_admin
      for k,v in pairs(ajuda) do
        text = text..k..' - '..v..'\n'
      end
      api.sendReply(msg, text, "HTML")
    end

    if bloco[1] == 'atualizar' then
      api.sendClean() db:bgsave() bot_init(true)
      att = utils.make_text(att, bot.first_name, #plugins)
      api.sendReply(msg, att, "HTML")
    end

    if bloco[1] == 'reiniciar' then
      api.sendClean() db:bgsave() is_started = false
      api.sendReply(msg, reiniciando, "HTML")
    end

    if bloco[1] == 'backup' then
      db:bgsave()
      utils.bash('sudo tar -cpf '..bot.first_name:gsub(' ', '_')..'.tar *')
      api.sendDocument(msg.from.id, './Backup/'..bot.first_name:gsub(' ', '_')..'.tar')
    end
    if bloco[1] == 'atualizar grupo' then
      if msg.chat.type == 'private' then return end
      db:srem('bot:gruposid', msg.chat.id)
      cross.initGroup(msg.chat.id)
      api.sendMessage(msg.chat.id, '*O Banco de Dados sobre este grupo foi resetado!*', 'Markdown')
    end
    if bloco[1] == 'publicar' then
      local res = api.sendLog(bloco[2], "Markdown")
      if not res then
        api.sendLog(markdown_error, "HTML")
      else
        local hash = 'bot:users'
        local ids = db:hkeys(hash)
        if ids then
          for i=1,#ids do
            api.sendMessage(ids[i], bloco[2], "Markdown")
          end
          api.sendReply(msg, publique_sim, "HTML")
        else
          api.sendReply(msg, sem_id_nao_publicado, "HTML")
        end
      end
    end

    if bloco[1] == 'sendGP' then
      local res = api.sendLog(bloco[2], "Markdown")
      if not res then
        api.sendLog(markdown_error, "HTML")
        return
      end
      local grupos = db:smembers('bot:gruposid')
      if not grupos then
        api.sendReply(msg, sem_id_nao_publicado, "HTML")
      else
        for i=1,#grupos do
          api.sendMessage(grupos[i], bloco[2], "Markdown", true)
        end
        api.sendReply(msg, publicado, "Markdown")
      end
    end

    if bloco[1] == 'run' then
      local input = bloco[2]
      input = input:gsub('—', '--')
      if not input then
        api.sendReply(msg, lang_pt.sem_cmd)
        return
      end
      local output = utils.bash(input)
      if output:len() == 0 then
        output = utils.make_text(servidor,'```- OK```')
      else
        output = utils.make_text(servidor,'```'..output..'```')
      end
      api.sendMessage(msg.chat.id, output, "Markdown", true, msg.message_id)
    end

    if bloco[1] == 'git' then
      local input = bloco[2]
      input = input:gsub('—', '--')
      if not input then
        api.sendReply(msg, lang_pt.sem_cmd)
        return
      end
      local output = utils.bash('git '..input)
      if output:len() == 0 then
        output = utils.make_text(servidor,'```- OK```')
      else
        output = utils.make_text(servidor,'```'..output..'```')
      end
      api.sendMessage(msg.chat.id, output, "Markdown", true, msg.message_id)
    end

    if bloco[1] == 'logs' then
      local msg_invalida = sudo.msg_invalida
      if bloco[2] then
        if bloco[2] ~= 'del' then
          local reply = lang_pt.msg_pv
          if bloco[2] == 'msg' then
            api.sendDocument(msg.chat.id, './logs/msgs_errors.txt')
          elseif bloco[2] == 'dbswitch' then
            api.sendDocument(msg.chat.id, './logs/dbswitch.txt')
          elseif bloco[2] == 'errors' then
            api.sendDocument(msg.chat.id, './logs/errors.txt')
          elseif bloco[2] == 'starts' then
            api.sendDocument(msg.chat.id, './logs/starts.txt')
          elseif bloco[2] == 'additions' then
            api.sendDocument(msg.chat.id, './logs/additions.txt')
          elseif bloco[2] == 'usernames' then
            api.sendDocument(msg.chat.id, './logs/usernames.txt')
          else
            reply = msg_invalida..bloco[2]
          end
          if reply:match('^'..msg_invalida..'.*') then
            api.sendMessage(msg.chat.id, reply)
          end
        else
          if bloco[3] then
            local reply = logs.deletado
            if bloco[3] == 'msg' then
              utils.bash('sudo rm -rf logs/msgs_errors.txt')
            elseif bloco[3] == 'dbswitch' then
              utils.bash('sudo rm -rf logs/dbswitch.txt')
            elseif bloco[3] == 'errors' then
              utils.bash('sudo rm -rf logs/errors.txt')
            elseif bloco[3] == 'starts' then
              utils.bash('sudo rm -rf logs/starts.txt')
            elseif bloco[3] == 'starts' then
              utils.bash('sudo rm -rf logs/additions.txt')
            elseif bloco[3] == 'usernames' then
              utils.bash('sudo rm -rf logs/usernames.txt')
            else
              reply = msg_invalida..bloco[3]
            end
            if msg.chat.type ~= 'private' then
              if not string.match(reply, '^'..msg_invalida..'.*') then
                api.sendReply(msg, reply)
              else
                api.sendReply(msg, reply)
              end
            else
              if string.match(reply, '^'..msg_invalida..'.*') then
                api.sendMessage(msg.chat.id, reply)
              else
                api.sendMessage(msg.chat.id, reply)
              end
            end
          else
            utils.bash('sudo rm -rf logs')
            if msg.chat.type == 'private' then
              api.sendMessage(msg.chat.id, del_pasta, "HTML")
            else
              api.sendReply(msg, del_pasta, "HTML")
            end
          end
        end
      else
        local reply = logs.help
        if msg.chat.type == 'private' then
          api.sendMessage(msg.chat.id, reply, "HTML", false)
        else
          api.sendReply(msg, reply, "HTML")
        end
      end
    end

    if bloco[1] == 'sair' then
      local text
      if not bloco[2] then
        if msg.chat.type == 'private' then
          text = lang_pt.sem_id
        else
          text = utils.bot_leave(msg.chat.id, msg.chat.title)
        end
      else
        text = utils.bot_leave(bloco[2], msg.chat.title)
      end
      api.sendLog(text, "HTML")
    end

    if bloco[1] == 'download' then
      if not msg.reply then
        api.sendMessage(msg.chat.id, lang_pt.msg_repita)
      else
        local type
        local file_id
        local file_name
        local text
        msg = msg.reply
        if msg.document then
          type = 'document'
          file_id = msg.document.file_id
          file_name = msg.document.file_name
        elseif msg.sticker then
          type = 'sticker'
          file_id = msg.sticker.file_id
          file_name = 'sticker.png'
        elseif msg.audio then
          type = 'audio'
          file_id = msg.audio.file_id
          file_name = msg.audio.title or msg.audio.performer or 'audio.mp3'
        end
        local res = api.getFile(file_id)
        local download_link = utils.DownloadLink(res)
        local path, code = utils.DownloadFile(download_link, './download/'..file_name)
        if path then
          text = '<b>Salvo!</b> <code>'..path:gsub('./download','\n📂 download\n ↪️ '):gsub('/', '')..'</code>'
        else
          text = '<b>O download falhou</b>'
        end
        api.sendReply(msg, text, "HTML")
      end
    end

    if bloco[1] == 'postar' then
      if config.canal == '' then
        api.sendMessage(msg.from.id, sudo.sem_canal)
      else
        local res = api.sendMessage(config.canal, bloco[2], "HTML", false)
        local text
        if res then
          text = publicado_em
        else
          text = nao_publique
        end
        api.sendReply(msg, text, "HTML")
      end
    end

    if bloco[1] == 'enviar' then
      if not bloco[2] then
        api.sendMessage(msg.from.id, lang_pt.sem_id)
        return
      end
      local id, text
      if bloco[2]:match('(-?%d+)') then
        if not bloco[3] then
          api.sendMessage(msg.from.id, lang_pt.sem_texto)
          return
        end
        id = bloco[2]
        text = bloco[3]
      else
        if not msg.reply then
          api.sendMessage(msg.from.id, lang_pt.repita_usuario)
          return
        end
        id = msg.reply.from.id
        text = bloco[2]
      end
      local res = api.sendMessage(id, text)
      if res then
        api.sendMessage(msg.chat.id, sudo.msg_ok, "HTML")
      end
    end

    if bloco[1] == 'responder' then
      if not msg.reply then
        api.sendReply(msg, lang_pt.msg_repita)
        return nil
      end

      local input = bloco[2]..sudo.rodape_feedback
      if not input then
        api.sendMessage(msg.from.id, lang_pt.sem_texto)
        return
      end

      msg = msg.reply_to_message
      local receiver = msg.forward_from.id

      local res = api.sendReply(msg, sudo.cabecario_feedback..input, "HTML")
      if res then
        api.sendMessage(receiver, input, "HTML", true)
      else
        api.sendReply(msg, markdown_error, "HTML")
      end
    end

    if bloco[1] == 'users' then
      local hash = 'bot:usernames'
      local usernames = db:hkeys(hash)
      local file = io.open("./usernames.txt", "w")
      file:write(utils.vardumptext(usernames):gsub('"', ''))
      file:close()
      api.sendDocument(msg.from.id, './usernames.txt')
      api.sendMessage(msg.chat.id, utils.make_text(sudo.msg_processada, #usernames), "HTML", true)
    end

    if bloco[1] == 'sudo' then
      if not msg.reply then
        api.sendLog(lang_pt.msg_repita)
        return
      end
      local user_id = msg.reply.from.id
      if bloco[2] == 'habilitar' then
        config.admin.admins[user_id] = true
      else
        config.admin.admins[user_id] = false
      end
      api.sendLog(sudo.habilitado)
    end

    if bloco[1] == 'req' then
      local url = 'https://api.telegram.org/bot' .. keys.ApiBot..'/'..bloco[2]
      print(url)
      local dat, code = HTTPS.request(url)
      local jdat = JSON.decode(dat)
      utils.vardump(jdat)
      api.sendLog("<code>"..utils.vardumptext(jdat).."</code>", "HTML")
    end

    if bloco[1] == 'db' then
      if bloco[2] == '00' then
        local output = utils.bash('redis-cli config get databases')
        if output then
          api.sendReply(msg, output)
        else
          api.sendReply(msg, 'OK')
        end
        return
      end
      local db_number = tonumber(bloco[2])
      db:select(db_number)
      api.sendReply(msg, utils.make_text(sudo.db_status, db_number, db_number), "HTML")
    end

    if bloco[1] == 'code' then
      api.sendLog(msg.chat.id)
    end

    if bloco[1] == 'redis' then
      local hash = 'bot:general'
      local names = db:hkeys(hash)
      local num = db:hvals(hash)
      local text = RD.cabecario
      local dbinfo = db:info()
      text = text..utils.make_text(RD.versao, dbinfo.server.redis_version)
      text = text..utils.make_text(RD.tempo_ativo, dbinfo.server.uptime_in_days, dbinfo.server.uptime_in_seconds)
      text = text..utils.make_text(RD.comandos_processados, dbinfo.stats.total_commands_processed)
      text = text..RD.dados
      for dbase,info in pairs(dbinfo.keyspace) do
        for real,num in pairs(info) do
          local keys = real:match('keys=(%d+),.*')
          if keys then
            text = text..' '..dbase..': <code>'..keys..'</code>\n'
          end
        end
      end
      text = text..utils.make_text(RD.expiradas, dbinfo.stats.expired_keys)
      if dbinfo.stats.total_net_input_bytes then
        text = text..utils.make_text(RD.Bytes_in, dbinfo.stats.total_net_input_bytes)
      end
      if dbinfo.stats.total_net_output_bytes then
        text = text..utils.make_text(RD.Bytes_in, dbinfo.stats.total_net_output_bytes)
      end
      api.sendMessage(msg.chat.id, text, "HTML", true)
    end

    if bloco[1] == 'stats' then
      local text = RD.cabecario_status
      local hash = 'bot:general'
      local names = db:hkeys(hash)
      local num = db:hvals(hash)
      for i=1, #names do
        text = text..'- <b>'..names[i]..'</b>: <code>'..num[i]..'</code>\n'
      end

      --text = text..utils.make_text(RD.apos_iniciar, tot)

      if config.canal and config.canal ~= '' then
        local channel_members = api.getChatMembersCount(config.canal).result
        text = text..utils.make_text(RD.canal_membros, channel_members)
      end

      local usernames = db:hkeys('bot:usernames')
      text = text..utils.make_text(RD.usuarios_que_utilizam, #usernames)
      api.sendMessage(msg.chat.id, text, "HTML", true)
    end

    if bloco[1] == 'salvar' then
      if not msg.reply then
        api.sendMessage(msg.chat.id, lang_pt.msg_repita)
        return
      end
      local id, type
      msg = msg.reply
      if msg.photo then
        id = msg.photo[1].file_id
        if not id then
          api.sendMessage(msg.chat.id, sudo.falha_id..utils.vardumptext(msg.photo))
          return
        end
        type = 'Foto'
      elseif msg.document then
        id = msg.document.file_id
        type = 'Documento'
      end
      db:set('pin:id', id)
      db:set('pin:type', type)
      api.sendMessage(msg.chat.id, utils.make_text(sudo.id_atribuido,id, type), "HTML", true)
    end

    if bloco[1] == 'delete' then
      db:del('pin:id', 'pin:type')
      api.sendLog('*ok*', "Markdown")
    end

    if bloco[1] == 'pin' then
      local id = db:get('pin:id')
      if not id then return end
      local type = db:get('pin:type')
      if type == 'Documento' then
        api.sendDocumentId(msg.chat.id, id, msg.message_id)
      elseif type == 'Foto' then
        api.sendPhotoId(msg.chat.id, id, msg.message_id)
      end
    end

    if bloco[1] == 'bloq' then
      local id
      if not bloco[2] then
        if not msg.reply then
          api.sendReply(msg, lang_pt.msg_repita)
          return
        else
          id = msg.reply.from.id
        end
      else
        id = bloco[2]
      end
      local response = db:sadd('bloqueando_mensagens', id)
      local text
      if response == 1 then
        text = id..' Foi bloqueado'
      else
        text = id..' Já está bloqueado'
      end
      api.sendReply(msg, text)
    end

    if bloco[1] == 'desbloq' then
      local id
      local response
      if not bloco[2] then
        if not msg.reply then
          api.sendReply(msg, lang_pt.msg_repita)
          return
        else
          id = msg.reply.from.id
        end
      else
        id = bloco[2]
      end
      local response = db:srem('bloqueando_mensagens', id)
      local text
      if response == 1 then
        text = id..' Foi desbloqueado'
      else
        text = id..' Já está desbloqueado'
      end
      api.sendReply(msg, text)
    end
    if bloco[1] == 'resetar' then
      if not bloco[2] then
        api.sendMessage(msg.from.id, 'ERROR!')
        return
      end
      local key = bloco[2]
      local hash, res
      if key == 'commands' then
        res = db:del('commands:stats')
      else
        res = db:hdel('bot:general', key)
      end
      if res > 0 then
        api.sendReply(msg, 'Resetado!')
      else
        api.sendReply(msg, sudo.msg_invalida)
      end
    end
  end
}
