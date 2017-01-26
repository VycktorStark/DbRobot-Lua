return {
  nome = "Ping",
  comandos = {
    init_cmd..'(ping)$',
    init_cmd..'(ping) (.*)$'
  },
  script = function(msg, bloco) -- crédito ao @TiagoDanin
    if not config.admin.admins[msg.from.id] then
      if not bloco[2] then
      else
        api.sendReply(msg, sudo.sudo.notSudo)
        return
      end
    end
    if not bloco[2] then
      api.sendReply(msg, sudo.sudo.ping.pong, "HTML")
    elseif bloco[2] == 'pong' then
      api.sendReply(msg, sudo.sudo.ping.pong, "HTML")
    elseif bloco[2] == 'clean' then
      api.sendClean()
      api.sendReply(msg, sudo.sudo.ping.clean, "HTML")
    elseif bloco[2] == 'server' then
      data = os.date('%d/%m/%Y - %T', msg.date)
      api.sendReply(msg, utils.make_text(sudo.sudo.ping.server, data, data), "HTML")
    elseif bloco[2] == 'redis' then
      if db:ping() then
        api.sendReply(msg, sudo.sudo.ping.redis, "HTML")
      else
        api.sendReply(msg, sudo.sudo.ping.not_redis, "HTML")
      end
    end
  end
}
