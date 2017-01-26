return {
  nome = "Dados",
  comandos = {
    init_cmd..'(dados)$'
  },
  script = function(msg, bloco)
    local dados = 'O Dado parou no número: 🎲 '..math.random(6)
    if dados then
      api.sendReply(msg, dados)
    end
  end
}
