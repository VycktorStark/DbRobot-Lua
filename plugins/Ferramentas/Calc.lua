return {
  nome = "Calculadora",
  comandos = {init_cmd..'([Cc][Aa][Ll][Cc])$',init_cmd..'([Cc][Aa][Ll][Cc]) (.*)$'},
  script = function(msg, bloco)
    if not bloco[2] then
      api.sendReply(msg, utils.make_text(desc[tr].ajuda, 'Calculadora', desc[tr].Calculadora), "HTML")
    else
      local ans, res = HTTP.request(apirequest.Ferramentas.Calc.. URL.escape(bloco[2]))
      if not ans then return end
      api.sendReply(msg, ans)
    end
  end
}
