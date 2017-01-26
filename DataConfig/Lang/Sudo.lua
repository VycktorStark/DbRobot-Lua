return {
  iniciando = {
    inicializando = '<b>&&&1 iniciado!\n'..
    '______________</b>\n'..
    '🤖 | <b>Username:</b> @&&&2\n'..
    '🖥 | <b>ID:</b> <code>&&&3</code>\n'..
    '🎛 | <b>Comandos carregados:</b> <code>&&&4</code>'..
    '<b>\n______________</b>\n'..
    os.date('📆 <b>Data de conexão:</b> <code>%d/%m/%Y</code>\n'..
    '⌚️ <b>Hora da conexão:</b> <code>%X</code>'),
    PulaLinha = '\n___________________\n',
    cmd_load = ' Comandos Carregados: ',
    id_text = ' ID: ',
    enviado = 'Enviada de um &&&1 (ID do grupo: &&&2)',
    infor_msg = '\nInformações: ',
    msg = '\nMensagem: ',
    data = '['..os.date('%X')..'] ',
    cmd_detectado = 'Combinação encontrada:',
    msg_error = '<b>Ocorreu um erro inesperado!!!</b>\n'..
    '<b>___________________</b>\n'..
    'Por favor, reporte o problema usando o comando:\n'..
  '\"<code>/suporte [</code><b>problema</b><code>]</code>\".'},
  sudo = {
    ping = {
      pong = '<b>Pong</b>',
      redis = '<b>Redis Pong</b>',
      not_redis = "<b>Redis OFF</b>",
      clean = '<b>Limpo!!!</b>',
      server = '<b>Server:</b> <code>&&&1</code>\n<b>Mensagem:</b> <code>&&&2</code>'
    },
    replyMSG = 'Responda diretamente a uma mensagem!',
    notSudo = "Ei, você não manda em mim!",
    error_de_conexao = 'Ocorreu um erro na conexão',
    reiniciando_servidor = 'Reiniciando servidor. . .',
    msg_invalida = 'Argumento inválido: ',
    id_atribuido = '<b>Pin atribuido:<b> <code>&&&1</code>\n'..
    '<b>Tipo:<b> <code>&&&2</code>',
    falha_id = 'ID não foi detectado\n\n',
    redis = {
      cabecario = '<b>Estatísticas do banco de dados</b>\n',
      versao = '- <b>Versão do banco de dados</b>: <code>&&&1</code>\n',
      tempo_ativo = '- <b>Tempo de Atividade</b>: <code>&&&1</code> (<code>&&&2 segundos</code>)\n',
      comandos_processados = '- <b>Comandos processados</b>: <code>&&&1</code>\n',
      dados = '- <b>Keys de dados</b>:\n',
      expiradas = '- <b>Keys expiradas</b>: <code>&&&1</code>\n',
      Bytes_in ='- <b>bytes de entrada</b>: <code>&&&1</code>\n',
      Bytes_out = '- <b>bytes de saida</b>: <code>&&&1</code>\n',
      apos_iniciar = '- <b>mensagens desde a última inicialização</b>: <code>&&&1</code>\n',
      usuarios_que_utilizam = '- <b>Usuários que me utilizam</b>: <code>&&&1</code>',
      canal_membros = '- <b>Membros no canal</b>: <code>&&&1</code>\n',
      cabecario_status = '<b>Estatísticas do Canal</b>\n'..
      '<b>___________________</b>\n'
    },
    logs = {
      deletado = 'Logs deletado com sucesso!',
      pasta_del = '`- Pasta de Logs excluída com sucesso!`',
      help = '<b>Registros disponíveis</b>:\n\n'..
      '<code>msg</code>: Erros durante a entrega de mensagens\n'..
      '<code>errors</code>: Erros durante a execução\n'..
      '<code>starts</code>: Quando o bot foi iniciado\n'..
      '<code>usernames</code>: Todos os nomes de usuário visto pelo bot\n'..
      '<code>additions</code>: Quando o bot foi adicionado a um grupo\n\n'..
      '<b>Use os seguintes comandos:</b>\n'..
      '<code>/logs [argumento]</code>\n'..
      '<code>/logs del [argumento]</code>\n'..
      '<code>/logs del </code> - deletar pasta inteira'
    },
    sem_canal = 'Nenhum canal informado.',
    msg_ok = '<b>Mensagem enviada com sucesso!</b>',
    db_status = '<b>Banco de dados atual:</b> <code>&&&1</code>\n'..
    '(Banco de dados principal: <code>&&&2</code>)',
    habilitado = 'Um novo sudo foi adicionado',
    msg_processada = '<b>Instrução processada</b>\n'..
    ' número total de usuário: <code>&&&1</code>',
    rodape_feedback = '\n<b>_______________</b>\n'..
    '<b>Atenciosamente, Equipe de Suporte.</b>',
    cabecario_feedback = '<b>Resposta enviada:</b>\n\n',
    feedback_help = '<b>Para enviar um feedback informando sua dúvida ou especificando alguma sugestão, Utilize o comando:</b> \"<code>/suporte</code>\" seguido o seu feedback.\nExemplo: \"<code>/suporte muito bom.</code>\"',
    feedback_enviado = '<b>Seu Feedback enviado com sucesso!</b>\n\n<code>Responderemos em breve. . .</code>',
    publicado_em = '<b>Mensagem postada em:<b> &&&1',
    nao_publique = 'falhar ao postar sua mensagem verifique o texto, e tente novamente.',
    markdown_error = 'Markdown está escrito de <b>forma incorreta!</b>',
    publicado = '<b>Publicação realizada com sucesso!</b>',
    publique_sim = '<b>Publicação realizada com sucesso!</b>\n'..
    '<b>Para saber quantos usuários receberam essa publicação, envie:</b><code>/users</code>',
    sem_id_nao_publicado = '<b>Sem Ids salvos</b>, nenhuma publicação foi feita!',
    servidor = '🖥 *Resposta do servidor:*\n\n &&&1',
    saiu = 'Sair do grupo: <b>&&&1</b>\nID do Grupo: <code>&&&2</code>',
    id_error = 'Verifique o id, que poderia estar errado',
    cabecario_admin = '🖥 <b>Comandos de sudo:</b>'..
    '\n<b>________________</b>\n',
    cabecario_arquivos = '📂 <b>Arquivos Salvos:</b> \n',
    reiniciando = '<code>- Reiniciando Servidor...</code>',
    att = '<b>&&&1 foi atualizado com sucesso!</b>\n'..
    'Cache foi limpado e todas as funções foram atualizadas.\n'..
    '<b>_______________\n'..
    '🎛 Comandos recarregados:</b> <code>&&&2</code>\n'..
    os.date('📆 <b>Data:</b> <code>%d/%m/%Y</code>\n'..
    '⌚️ <b>Hora:</b> <code>%X</code>'),
    ajuda = {
      '/arquivos - Para vê arquivos de plugins habilitados e fazer upload se houver necessidade.',
      '/atualizar - Para atualizar servidor.',
      '/backup - Para fazer backup do banco de dados.',
      '/db [code] - Para altera banco de dados.',
      '/download - Para fazer download de um conteúdo para o servidor.',
      '/enviar [texto] - Para enviar algo a alguém.',
      '/logs - Para vê opções para deleta arquivos de logs.',
      '/postar [texto] - Para postar algo no canal.',
      '/publicar [texto] - Para publicar algos aos usuários.',
      '/ping redis - Para pingar no banco de dados e atualizar.',
      '/ping server - Para verificar o tempo de resposta do servidor.',
      '/reiniciar - Para reiniciar servidor.',
      '/redis - Para verificar estatísticas do banco de dados.',
      '/run [ação] - Para executar algo no terminal.',
      '/sair - Para o bot sair do grupo. (pode ser usado com ID do grupo também)',
      '/sudo habilitar - Para nomear alguém sudo.',
      '/sudo remove - Para remover o sudo.',
      '/stats - Para mostar estatísticas do canal.'
  }},
  handle_exception = '\n`[' .. os.date('%T', os.time()) .. ']` #ALERTA\n*Novo error encontrado:* `&&&1`\n*Ocorreu executar:* &&&2\n*____________*\n#Detalhes\n*Nome do local:* &&&3\nTipo: &&&4\nID: &&&5',
  campos_em_branco = 'campos em falta',
  hast_nao_existe = 'Hash não existe',
  hast_sub = 'vazio sub-Hash',
  argumento_invalido = 'Argumento invalido',
  admin_on = '<b>Modo de administrador está em:</b> apenas o administrador pode adicionar-me a um novo grupo',
  grupoblock = '<b>Grupo bloqueado!!!</b>',
  addbot = '#ALERTA:\n<b>Bot foi adicionado ao grupo:</b>\n<code>Informações do Grupo = &&&1\n Informações do usuário = &&&2</code>',
  rembot = '#ALERTA:\n<b>Bot foi removido do grupo:</b>\n<code>Informações do Grupo = &&&1\n Informações do usuário = &&&2</code>',
  botrem = 'Bot foi removido do grupo ',
  idgrupo = ', ID do Grupo: ',
  savestatus = 'Salvando Status'
}
