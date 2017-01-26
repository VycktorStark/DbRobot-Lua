return {
  br = {
    tr = "pt",
    help = {
      mod = 'Toque em uma opção para ver as <b>configurações relacionadas</b>',
      version = '🤖 <b>&&&1 vs &&&2</b>\n<b>__________________</b>\nPara dúvidas ou envios de feedback, utilize o comando: <b>/suporte</b>',
      dedicando = '💢 <b>Dedicação:</b>\nDedico os meus sinceros créditos ao <a href="https://github.com/topkecleon">Drew</a>,criador do Otouto. Ao <a href="https://github.com/tiagodanin">Tiago Danin</a>, <a href="https://github.com/Synk0">Wesley Henrique</a> da equipe <b>Synko Developers</b>.',
      intro = "Olá, <b>&&&1</b>!\nEu sou um bot simples criado para ajudar as pessoas a gerir os seus grupos. <b>O que posso fazer para você?</b>\n\n- Eu tenho um monte de ferramentas úteis! que você pode conhecer visualizando meus comandos.",
      titulo = "📖 <b>Lista de Comandos</b>:\n",
      rodape = "<b>____________</b>\nℹ️ Envie <code>/ajuda [</code><b>nome</b><code>/</code><b>número</b><code>]</code> para saber como utilizar tal comando, ou clique sobre o atalho destacado.",
      CallbackQuery = 'ℹ️ Essa são as informações sobre este comando.',
      loopCallback = '⚠️️ Você já está nesta opção...'
    },
    afk = {
      on = '⏰ <b>Notificação de Status:\n______________\n</b> &&&1, <b>Está de volta!</b>',
      off = '⏰ <b>Notificação de Status:\n______________\n</b> &&&1, <b>Está ausente!</b>',
      off_motivo = '⏰ <b>Notificação de Status:\n______________\n</b> &&&1, <b>Está ausente!\nMotivo</b> <code>&&&2</code>'
    },
    erros = {
      nao_adm = 'Não sou admin, não posso remover nenhum membro',
      eh_um_adm = 'Não posso remover ou banir um(a) admins',
      grupo_normal = 'Não há necessidade de desbanir num grupo comum',
      nao_eh_mais_membro = 'Este usuário não é um membro deste grupo'
    },
    banhammer = {
      flood = '&&&1 <b>banido(a)</b> por flood',
      banhammer = '<b>Banido por flood!<b>',
      kick = '&&&1 <b>removido(a)</b> por flood',
      noob_flood = 'Por favor, não abuse do teclado, os pedidos serão ignorado!',
      RTL = '&&&1 <b>removido(a)</b>: Neste grupo, mensagem reversas não são permitidas!',
      arabes = '&&&1 <b>removido(a)</b>: Neste grupo, mensagem arabes não são permitidas!'
    },
    setlang = {
      list = '<b>Lista de idiomas disponíveis:</b>\n\nUtilize os botões abaixo ou <code>/lang sigla</code> para seu idioma.',
      error = 'O idioma selecionado <b>não é suportado</b>. Use <code>/lang</code> para ver a lista de idiomas disponíveis.',
      success = '<b>Novo idioma selecionado:</b> &&&1'
    },
    bonus = {
      texto_longo = "O texto enviado é muito longo e o tamanho não é suportado. Por Favor envie-me um texto menor.",
      error_markdown = '<b>O texto que você me enviou estava escrito incorretamente, certifique-se de que todas as palavras estão escritas corretamente com o sistema de formatação.</b>\n<i>Use a sintaxe a seguir em sua mensagem:</i>\n<code>*Texto em Negrito*\n_Texto em Itálico_\n`Código embutido de largura fixa`\n```Bloco de código pré-formatado de largura fixa```\n[Texto](URL)</code>'
    },
    ID = {
      nome = "<b>Nome:</b> &&&1\n<b>ID:</b> <code>&&&2</code>\n<b>______________</b>",
      username = '<a href="https://telegram.me/&&&1">&&&2</a>\n<b>Username:</b> @&&&3',
      grupo = "&&&1\n<b>Nome do Grupo:</b> &&&2\n<b>ID:</b> <code>&&&3</code>",
      IDGrupo = '&&&1\n<b>Você está em uma mensagem privada comigo!</b>'
    },
    IA = {
      alterando = "#ALERTA\n<b>A Inteligência artificial foi alterada para o modo</b> <code>&&&1</code>",
      titulo = "<b>Menu de Ajuda para configurar a Inteligência artificial do DB:</b>\n<code>/IA ",
      help = {
        '</code> <b>-</b> Altera para o modo de Inteligência artificial <code>Normal</code>.',
        '</code> <b>-</b> Altera para o modo de Inteligência artificial <code>Sexual</code>.',
        '</code> <b>-</b> Altera para o modo de Inteligência artificial <code>Violento</code>.',
        '</code> <b>-</b> Altera para o modo de Inteligência artificial <code>Personalizado</code>.',
      },
      rodape = '&&&1habilitar</code> <b>-</b> Habilitar IA\n<code>/IA desabilitar</code> <b>-</b> Desabilitar IA',
      not_msg = {"SEU ARROMBADO FDP","POLICIA AQUI E DBZINHOOO TEM UM CARA ME STALKEANDO SOCORU",'q foi', 'kié', 'oque vc q Comigo me deixa em paz poha!!!'}
    },
    settings = {
      habilitar_plugin = 'O comando <code>&&&1</code> foi habilitado!',
      habilitado = 'O comando <code>&&&1</code> já está habilitado!',
      desabilitar_plugin = 'O comando <code>&&&1</code> foi desabilitado!',
      desabilitado = 'O comando <code>&&&1</code> já está desabilitado!'
    },
    not_mod = 'Você *não* é um(a) moderador(a)',
    msg_pv = '<b>Enviei-lhe em uma mensagem privada.</b>',
    sem_id = 'ID não informado!',
    sem_cmd = 'Por favor, especifique algum comando!.',
    sem_texto = 'Nenhum texto foi escrito, por favor escreva algo!.',
    repita_usuario = 'Responda diretamente a um usuário para enviar-lhe uma mensagem',
    msg_repita = 'Responda diretamente a uma mensagem, Por favor!',
    nao_start = 'Verifiquei aqui e você nunca iniciou uma conversa comigo no privado!\n\n'..
    '<b>Clique abaixo para iniciar uma conversa comigo.</b>',
    start = '🤖 Iniciar conversar',
    not_repita = 'Por favor, escrevar algo para que eu possar repetir.',
    novoGrupo = '<b>Fala ae cambada,</b>\n\nEsse serumaninho <a href="https://telegram.me/&&&1">&&&2</a> me adicionou aqui para entreter este grupo, Ae vai uma dica do Dbzinho - Participe do meu canal <a href="https://telegram.me/joinchat/Cx35iEGPtFhmqAob9QrC0w">@RoboDb</a>'
  },
  en ={
    tr = "en",
    help = {
      mod = 'Tap an option to see the <b>related settings</b>',
      version = '🤖 <b>&&&1 vs &&&2</b>\n<b>__________________</b>\nFor questions or feedback, use the command: <b>/feedback</b>',
      dedicando = '💢 <b>Dedication:</b>\nI dedicate my sincere credit to <a href="https://github.com/topkecleon">Drew</a>, creator Otouto. For <a href="https://github.com/tiagodanin">Tiago Danin</a>, <a href="https://github.com/Synk0">Wesley Henrique</a> from Team <b>Synko Developers</b>.',
      intro = "Hello, <b>&&&1</b>!\nI am a simple bot created to help people manage their groups. <b>What can I do for you?</b>\n\n- I have a lot of useful tools! That you can know to view my commands.",
      titulo = "📖 <b>Commands List</b>:\n",
      rodape = "\n<b>____________</b>\nℹ️ Send <code>/help [</code><b>name</b><code>/</code><b>number</b><code>]</code> to know how to use such a command, or click on the highlighted shortcut.",
      CallbackQuery = 'ℹ️ This is the information about this command.',
      loopCallback = '⚠️️ You are already in this option...'
    },
    afk = {
      on ='⏰ <b>Status notification \n_________________\n</b> &&&1, <b>Is back!</b>',
      off ='⏰ <b>Status notification \n_________________\n</b> &&&1, <b>Is absent!</b>',
      off_motivo ='⏰ <b>Status notification \n_________________\n</b> &&&1, <b>Is absent!\nReason</b> <code>&&&2</code>',
    },
    erros = {
      nao_adm = 'I\'m not admin, I can not remove any member',
      eh_um_adm = 'I can not remove or ban a (a) admins',
      grupo_normal = 'No need to unban a common group',
      nao_eh_mais_membro = 'This user is not a member of this group'
    },
    banhammer = {
      flood = '<b>&&&1 banned (a)</b> for flood',
      BanHammer = '<b>Banished for flood!*',
      kick = '<b>&&&1 removed (a)</b> for flood',
      noob_flood = 'Please do not abuse the keyboard, requests will be ignored!',
      RTL = '<b>&&&1 removed (a)</b>: In this group, reverse message are not allowed!',
      Arab = '<b>&&&1 removed (a)</b>: In this group, Arab message are not allowed!'
    },
    setlang = {
      list = '<b>List of available languages:</b>\n\nUse the buttons below or <code>:/lang initials</code>: for your language.',
      error = 'The language setted is <b>not supported</b>. Use <code>:/lang</code>: to see the list of the available languages',
      success = '<b>New language setted:</b> &&&1'
    },
    bonus = {
      texto_longo = "Sent text is too long and size is not supported. Please send me a smaller text",
      error_markdown = '<b>The text you sent me was spelled incorrectly, make sure all words are spelled correctly with the formatting system.</b>\n<i>Use the following syntax in your message:</i>\n<code>*bold text*\n_talic text_`inline fixed-width code`\n```pre-formatted fixed-width code block```\n[text](URL)</code>',
    },
    ID = {
      nome = "<b>Name:</b> &&&1\n<b>ID:</b> <code>&&&2</code>\n<b>______________</b>",
      username = '<a href="https://telegram.me/&&&1">&&&2</a>\n<b>Username:</b> @&&&3',
      grupo = "&&&1\n<b>Group's name:</b> &&&2\n<b>ID:</b> <code>&&&3</code>",
      IDGrupo = '&&&1\n<b>You are in a private message with me!</b>'},
    IA = {
      alterando = "#ALERT\n<b>Artificial Intelligence changed to</b> <code>&&&1</code> <b>mode</b>",
      titulo = "<b>Help Menu to configure Artificial Intelligence:</b>\n<code>/IA ",
      help = {
        '</code> <b>-</b> Switch to the Artificial Intelligence mode for <code>Normal</code>.',
        '</code> <b>-</b> Switch to the Artificial Intelligence mode for <code>Sexual</code>.',
        '</code> <b>-</b> Switch to the Artificial Intelligence mode for <code>Violento</code>.',
        '</code> <b>-</b> Switch to the Artificial Intelligence mode for <code>Personalizado</code>.',
      },
      rodape = '&&&1enable</code> <b>-</b> Enable IA\n<code>/IA disable</code> <b>-</b> Disable IA',
      not_msg = {"SEU ARROMBADO FDP","POLICIA AQUI E DBZINHOOO TEM UM CARA ME STALKEANDO SOCORU",'q foi', 'kié', 'oque vc q Comigo me deixa em paz poha!!!'}
    },
    settings = {
      habilitar_plugin = 'The <code>&&&1</code> command has been enabled.',
      habilitado = 'The <code>&&&1</code> command is already enabled!',
      desabilitar_plugin = 'The <code>&&&1</code> command has been disabled.',
      desabilitado = 'The <code>&&&1</code> command is already disabled!'
    },
    not_mod = 'You are *not* a moderator(a)',
    msg_pv = '<b>I sent you a private message in</b>',
    sem_id = 'Not Set ID!',
    sem_cmd = 'Please specify any command !.',
    sem_texto = 'No text was written, please write something!',
    repita_usuario = 'reply directly to a user to send you a message',
    msg_repita = 'reply directly to a message, Please!',
    nao_start = 'I checked here and you never started a conversation with me in private!\n\n' ..
    '<b>Click below to start a conversation with me.</b>',
    start = '🤖 Start talking',
    not_repita = 'Please write something so I can repeat.',
    novoGrupo = '<b>Speak cambada the,</b>\n\nThat serumaninho <a href="https://telegram.me/&&&1">&&&2</a> added me to entertain this group, Dbzinho\'s tip - Join my channel <a href="https://telegram.me/joinchat/Cx35iEGPtFhmqAob9QrC0w">@RoboDb</a>'
  }
}
