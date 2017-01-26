return {
  nome = "Zueira",
  comandos = {init_cmd..'(eu sou)(.*)$'},
  script = function(msg, bloco)
    local eusou_random = {"Sim"," É ao contrario "," Acho que é ao contrario "," Eu te pego😏","Não","Nunca","Com certeza","Nunca tive duvidas","Antes não, mas agora sim","Não sei","Respondo nem desligado","Ainda quer que eu prove?"," Nunca foi e nunca vai ser","Não, nunca","Ainda não","Somos😍"}
    local eusou = eusou_random[math.random(#eusou_random)]
    if eusou then
      api.sendReply(msg, eusou)
    end
  end
}
