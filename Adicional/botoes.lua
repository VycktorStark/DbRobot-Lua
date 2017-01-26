function make_keyboard(mod, mod_current_position)
  local keyboard = {}
  keyboard.inline_keyboard = {}
  if mod then
    local list = {
      ['botao 1'] = '!botao1',
      ['botao 2'] = '!botao2',
    }
    local line = {}
    for k,v in pairs(list) do
      if next(line) then
        local button = {text = ' '..k, callback_data = v}
        if mod_current_position == v:gsub('!', '') then button.text = ' '..k end
        table.insert(line, button)
        table.insert(keyboard.inline_keyboard, line)
        line = {}
      else
        local button = {text = ' '..k, callback_data = v}

        if mod_current_position == v:gsub('!', '') then button.text = ' '..k end
        table.insert(line, button)
      end
    end
    if next(line) then
      table.insert(keyboard.inline_keyboard, line)
    end
  end
  local bottom_bar
  if mod then
    bottom_bar = {{text = '🖥 Comandos', callback_data = '!user'}}
  else
    bottom_bar = {{text = '⚙ Extras', callback_data = '!mod'}}
  end
  table.insert(bottom_bar, {text = '🤖 Informações', callback_data ='!info_buttond'})
  table.insert(keyboard.inline_keyboard, bottom_bar)
  return keyboard
end

function doKeyboard_lang()
  local keyboard = {inline_keyboard = {}}
  for i,lang in pairs(config.idioma) do
    idioma = lang:gsub("en","🇺🇸 Ingles (en)"):gsub("br","🇧🇷 Português (br)")
    local line = {{text = idioma, callback_data = '!langselected:'..lang}}
    table.insert(keyboard.inline_keyboard, line)
  end
  return keyboard
end

function do_keybaord_credits()
  local keyboard = {}
  keyboard.inline_keyboard = {
    {{text = '💢 Dedicação', callback_data = '!dedic'}},
    {{text = '🔙 Comandos', callback_data = '!user'},
      {text = '⭐️ Avaliar me!', url = 'https://telegram.me/storebot?start='..bot.username}}}
  return keyboard
end

function do_keybaord_dedic()
  local keyboard = {}
  keyboard.inline_keyboard = {{{text = '🔙 Voltar', callback_data = '!info_buttond'},
      {text = '🗣 Canal Oficial', url = 'https://telegram.me/RoboDb'}}}
  return keyboard
end

function do_keyboard_private()
  local keyboard = {}
  keyboard.inline_keyboard = {{{text = '🖥 Todos os comandos', callback_data = '!user'}},
    {{text = '👥 Convidar bot', url = 'https://telegram.me/'..bot.username..'?startgroup=new'},
      {text = '🗣 Canal Oficial', url = 'https://telegram.me/RoboDb'}}}
  return keyboard
end

function do_keyboard_startme()
  local keyboard = {}
  keyboard.inline_keyboard = {{{text = lang[tr].start, url = 'https://telegram.me/'..bot.username}}}
  return keyboard
end
