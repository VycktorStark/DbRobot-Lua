local underline_pular = "\n<b>_____________</b>\n"
return {
  br = {
    ajuda = "📖 <b>Ajuda para o comando:</b> <code>&&&1</code>\n\n&&&2",
    not_cmd = 'Desculpe, não há ajuda para esse comando.',
    Calculadora = "Realizar Cálculos matemáticos."..underline_pular..'<b>Exemplo:</b>\n•<code>/calc [</code><b>expressão</b><code>]</code> - Para calcular uma expressão matemática.',
    Help = "Informar instruções dos comandos."..underline_pular.."<b>Exemplo:</b>\n• <code>/ajuda Help</code> <b>-</b> Para receber instruções sobre o comando help.\n• <code>/ajuda 3</code> <b>-</b> Para receber instruções sobre o comando help.",
    Afkre = "Alerta de status. (<b>Utilizem em um grupo</b>)"..underline_pular.."<b>Exemplo:</b>\n•<code>/afk</code> <b>-</b> Para informar que você não pode responder.\n•<code>/re</code> <b>-</b> Para informar que você já pode responder.",
    Lang = "Alterar o idioma do bot. (<b>Ser usado no grupo só mudará a linguagem do grupo</b>)"..underline_pular.."<b>Exemplo:</b>\n• <code>/lang sigla</code> <b>-</b> Para o seu idioma.",
    Ping = "Verifique a disponibilidade do bot, ele irá retornar uma mensagem para exibir que está on-line"..underline_pular.."<b>Exemplo:</b>\n• <code>/ping</code> <b>-</b> Para o Bot retornar uma mensagem com <b>pong</b> se estiver on-line.",
    -- off StoreApp = ""..underline_pular.."<b>Exemplo:</b>\n•Sem descrição ainda...",
    Fap = " 🔞 Comando Adulto, Por favor, execute apenas se você tem mais de 18 anos de idade.\n🔞 <b>NSFW</b> 🔞"..underline_pular.."<b>Exemplo:</b>\n• <code>/fap</code> <b>-</b> Para obter uma imagem aleatória.\n• <code>/boobs</code> <b>-</b> Para obter uma imagem de peitos.\n• <code>/butts</code> <b>-</b> Para obter uma imagem de bundas.",
    Repita = "Comando de reply."..underline_pular.."<b>Exemplo:</b>\n• <code>/repita (Frase)</code> <b>-</b> Então o robô repete o que foi escrito.",
    ['Chuck Norris'] = 'Comando que exibe piadas de Chuck Norris. ( <code>Somente em inglês</code>)'..underline_pular..'<b>Exemplo:</b>\n• <code>/chuck</code> <b>-</b> Para receber piadas aleatórias de Chuck Norris',

  },
  en = {
    ajuda = "📖 <b>Help for the command:</b> <code>&&&1</code>\n\n&&&2",
    not_cmd = 'Sorry, there is no help for that command.',
    Calculadora = "Perform Mathematical Calculations."..underline_pular.."<b>Example:</b>\n• <code>/calc [</code><b>expression</b><code>]</code> - To calculate a mathematical expression.",
    Help = "Inform instructions for commands."..underline_pular.."<b>Example:</b>\n• <code>/help Help</code> <b>-</b> For instructions on the help command.\n• <code>/help 3</code> <b>-</b> For instructions on the help command.",
    Afkre = "Status Alert. (<b>Use in a group</b>)"..underline_pular.."<b>Example:</b>\n• <code>/afk</code> <b>-</b> To report that you can not respond.\n•<code>/re</code> <b>-</b> To inform you that you can already reply.",
    Lang = "Change the language of the bot. (<b>Being used in the group will only change the language of the group</b>)"..underline_pular.."<b>Example:</b>\n• <code>/lang initials</code> <b>-</b> For your language.",
    Ping = "Check bot availability, it will return a message to display that is online"..underline_pular.."<b>Example:</b>\n• <code>/ping</code> <b>-</b> For the Bot to return a message with <b>pong</b> if it is online.",
    -- off StoreApp = ""..underline_pular.."<b>Example:</b>\n•No description yet...",
    Fap = "Adult Command, Please only execute if you are over 18 years old.\n🔞 <b>NSFW</b> 🔞"..underline_pular.."<b>Example:</b>\n• <code>/fap</code> <b>-</b> To get a Random Image\n• <code>/boobs</code> <b>-</b> To get a boobs image.\n• <code>/butts</code> <b>-</b> To get a butt image.",
    Repita = "Reply command."..underline_pular.."<b>Example:</b>\n• <code>/echo (whatever)</code> <b>-</b> So the robot repeats what was written.",
    ['Chuck Norris'] = 'Command that displays Chuck Norris jokes. ( <code>English only</code>)'..underline_pular..'<b>Example:</b>\n• <code>/chuck</code> <b>-</b> To get random jokes of Chuck Norris',

}}
