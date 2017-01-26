return {
  nome = "Jokenpo",
  comandos = {init_cmd..'(teste)$',init_cmd..'(✊)$',init_cmd..'(✊🏻)$',init_cmd..'(✊🏼)$',init_cmd..'(✊🏽)$',init_cmd..'(✊🏾)$',init_cmd..'(✊🏿)$',init_cmd..'(✌️)$',init_cmd..'(✌️)$',init_cmd..'(✌🏼)$',init_cmd..'(✌🏽)$',init_cmd..'(✌🏾)$',init_cmd..'(✌🏿)$',init_cmd..'(✋)$',init_cmd..'(✋🏻)$',init_cmd..'(✋🏼)$',init_cmd..'(✋🏽)$',init_cmd..'(✋🏾)$',init_cmd..'(✋🏿)$'},
  script = function(msg, bloco)
    local jokenpo_random = {"✊🏻","✋🏻","✊🏻","✌🏻","✋🏻","✊🏻","✌🏻"}
    local jokenpo = jokenpo_random[math.random(#jokenpo_random)]
    if jokenpo then
      api.sendReply(msg, jokenpo)
    end
  end
}
