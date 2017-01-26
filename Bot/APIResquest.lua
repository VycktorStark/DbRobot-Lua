local BASE_URL = 'https://api.telegram.org/bot' .. keys.ApiBot

local PWR_URL = 'https://api.pwrtelegram.xyz/bot' .. keys.ApiBot

if not keys.ApiBot then
  error('Você não definiu seu token de bot em api.lua!')
end

local api = {}

function sendRequest(url)
  local dat, code = HTTPS.request(url)
  if not dat then
    return false, code
  end
  local tab = JSON.decode(dat)
  if code ~= 200 then
    if tab and tab.description then print(cor.onwhite..cor.red..code, tab.description..cor.reset) end
    if code == 400 then code = api.getCode(tab.description) end
    db:hincrby('bot:errors', code, 1)
    if code ~= 403 and code ~= 429 and code ~= 110 and code ~= 111 then
      api.sendLog('Erro encontrado:\n\n'..utils.vardumptext(dat)..'\n'..code)
      end return false, code end
      if not tab.ok then
        return false, tab.description
        end return tab end

        function api.sendClean()
          local url = BASE_URL .. '/getUpdates?timeout=0&offset=1'
          print('Limpando cache do bot . . .')
        end -- Crédito ao @Tiagodanin

        function api.sendInline(inline_id, result, disable_web_page_preview)
          local url = BASE_URL .. '/answerInlineQuery?inline_query_id=' .. inline_id .. '&results=' .. result
          if disable_web_page_preview == true then
            url = url .. '&disable_web_page_preview=true'
          end
          return sendRequest(url)
        end

        function api.getMe()
          local url = BASE_URL .. '/getMe'
          return sendRequest(url)
        end

        function api.getUpdates(offset)
          local url = BASE_URL .. '/getUpdates?timeout=20'
          if offset then
            url = url .. '&offset=' .. offset
          end
          return sendRequest(url)
        end

        function api.getCode(error)
          for k,v in pairs(erros.api_errors) do
            if error:match(v) then
              return k
            end
          end
          return 7
        end

        function api.unbanChatMember(chat_id, user_id)
          local url = BASE_URL .. '/unbanChatMember?chat_id=' .. chat_id .. '&user_id=' .. user_id
          local dat, res = HTTPS.request(url)
          local tab = JSON.decode(dat)
          if res ~= 200 then
            return false, res
          end
          if not tab.ok then
            return false, tab.description
          end
          return tab
        end

        function api.kickChatMember(chat_id, user_id)
          local url = BASE_URL .. '/kickChatMember?chat_id=' .. chat_id .. '&user_id=' .. user_id
          local dat, res = HTTPS.request(url)
          local tab = JSON.decode(dat)
          if res ~= 200 then
            print(tab.description)
            return false, api.getCode(tab.description)
          end
          if not tab.ok then
            return false, tab.description
          end
          return tab
        end

        function api.code2text(code)
          if code == 101 or code == 105 or code == 107 then
            return lang[tr].erros.nao_adm
          elseif code == 102 or code == 104 then
            return lang[tr].erros.eh_um_adm
          elseif code == 103 then
            return lang[tr].erros.grupo_normal
          elseif code == 106 then
            return lang[tr].erros.nao_eh_mais_membro
          elseif code == 7 then
            return false
          end
          return false
        end

        function api.banUserId(chat_id, user_id, name, on_request, no_msg)
          local msg = {}
          msg.chat = {}
          msg.from = {}
          msg.chat.id = chat_id
          msg.from.id = user_id
          msg.from.first_name = name
          return api.banUser(msg, on_request, no_msg)
        end

        function api.banUser(chat_id, user_id, is_normal_group)
          local res, code = api.kickChatMember(chat_id, user_id)

          if res then
            db:hincrby('bot:general', 'ban', 1)
            if is_normal_group then
              local hash = 'chat:'..chat_id..':banned'
              db:sadd(hash, user_id)
            end
            return res
          else
            local text = api.code2text(code)
            return res, text
          end
        end

        function api.kickUser(chat_id, user_id)
          local res, code = api.kickChatMember(chat_id, user_id)
          if res then
            db:hincrby('bot:general', 'kick', 1)
            api.unbanChatMember(chat_id, user_id)
            api.unbanChatMember(chat_id, user_id)
            return res
          else
            local motivation = api.code2text(code)
            return res, motivation
          end
        end

        function api.unbanUser(chat_id, user_id, is_normal_group)
          if utils.is_mod2(chat_id, user_id) then return end
          if is_normal_group then
            local hash = 'chat:'..chat_id..':banned'
            local removed = db:srem(hash, user_id)
            if removed == 0 then
              return false
            end
          else
            local res, code = api.unbanChatMember(chat_id, user_id)
          end
          return true
        end

        function api.getChat(chat_id)
          local url = BASE_URL .. '/getChat?chat_id=' .. chat_id
          return sendRequest(url)
        end

        function api.resolveUsername(username)
          local url = PWR_URL..'/getChat?chat_id=' .. username
          local dat, code = HTTPS.request(url)
          if not dat then
            return false, code
          end
          local tab = JSON.decode(dat)
          if not tab then
            return false
          else
            if tab.ok then
              return tab.result
            end
          end
        end

        function api.getChatAdministrators(chat_id)
          local url = BASE_URL .. '/getChatAdministrators?chat_id=' .. chat_id
          return sendRequest(url)
        end

        function api.getChatMembersCount(chat_id)
          local url = BASE_URL .. '/getChatMembersCount?chat_id=' .. chat_id
          return sendRequest(url)
        end

        function api.getChatMember(chat_id, user_id)
          local url = BASE_URL .. '/getChatMember?chat_id=' .. chat_id .. '&user_id=' .. user_id
          return sendRequest(url)
        end

        function api.leaveChat(chat_id)
          local url = BASE_URL .. '/leaveChat?chat_id=' .. chat_id
          return sendRequest(url)
        end

        function api.sendKeyboard(chat_id, text, keyboard, markdown)
          local url = BASE_URL .. '/sendMessage?chat_id=' .. chat_id
          if markdown then
            url = url .. '&parse_mode='..markdown
          end
          url = url..'&text='..URL.escape(text)
          url = url..'&disable_web_page_preview=true'
          url = url..'&reply_markup='..JSON.encode(keyboard)
          return sendRequest(url)
        end

        function api.sendMessage(chat_id, text, format, preview, reply_to_message_id, send_sound)
          local url = BASE_URL .. '/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text)
          if reply_to_message_id then
            url = url .. '&reply_to_message_id=' .. reply_to_message_id
          end
          if format then
            url = url .. '&parse_mode='..format
          end
          if preview then
            url = url .. '&disable_web_page_preview=true'
          end
          if not send_sound then
            url = url..'&disable_notification=true'
          end
          local res, code = sendRequest(url)
          if not res and code then
            if code ~= 403 and code ~= 429 and code ~= 110 and code ~= 111 then
            end
          end
          return res, code
        end

        function api.sendReply(msg, text, format, send_sound)
          return api.sendMessage(msg.chat.id, text, format, false, msg.message_id, send_sound)
        end

        function api.editMessageText(chat_id, message_id, text, keyboard, markdown)
          local url = BASE_URL .. '/editMessageText?chat_id=' .. chat_id .. '&message_id='..message_id..'&text=' .. URL.escape(text)
          if markdown then
            url = url .. '&parse_mode='..markdown
          end
          url = url .. '&disable_web_page_preview=true'
          if keyboard then
            url = url..'&reply_markup='..JSON.encode(keyboard)
          end
          return sendRequest(url)
        end

        function api.answerCallbackQuery(callback_query_id, text, show_alert)
          local url = BASE_URL .. '/answerCallbackQuery?callback_query_id=' .. callback_query_id .. '&text=' .. URL.escape(text)
          if show_alert then
            url = url..'&show_alert=true'
          end
          return sendRequest(url)
        end

        function api.sendChatAction(chat_id, action)
          local url = BASE_URL .. '/sendChatAction?chat_id=' .. chat_id .. '&action=' .. action
          return sendRequest(url)
        end

        function api.sendLocation(chat_id, latitude, longitude, reply_to_message_id)
          local url = BASE_URL .. '/sendLocation?chat_id=' .. chat_id .. '&latitude=' .. latitude .. '&longitude=' .. longitude
          if reply_to_message_id then
            url = url .. '&reply_to_message_id=' .. reply_to_message_id
          end
          return sendRequest(url)
        end

        function api.forwardMessage(chat_id, from_chat_id, message_id)
          local url = BASE_URL .. '/forwardMessage?chat_id=' .. chat_id .. '&from_chat_id=' .. from_chat_id .. '&message_id=' .. message_id
          return sendRequest(url)
        end

        function api.getFile(file_id)
          local url = BASE_URL .. '/getFile?file_id='..file_id
          return sendRequest(url)
        end

        function api.sendPhotoId(chat_id, file_id, reply_to_message_id)
          local url = BASE_URL .. '/sendPhoto?chat_id=' .. chat_id .. '&photo=' .. file_id
          if reply_to_message_id then
            url = url..'&reply_to_message_id='..reply_to_message_id
          end
          return sendRequest(url)
        end

        function api.sendDocumentId(chat_id, file_id, reply_to_message_id)
          local url = BASE_URL .. '/sendDocument?chat_id=' .. chat_id .. '&document=' .. file_id
          if reply_to_message_id then
            url = url..'&reply_to_message_id='..reply_to_message_id
          end
          return sendRequest(url)
        end

        function curlRequest(curl_command)
          io.popen(curl_command)
        end

        function api.sendPhoto(msg, photo, texto)
          local url = BASE_URL .. '/sendPhoto?chat_id='.. msg.chat.id
          if photo then
            url = url..'&photo='..photo
          end
          if texto then
            url = url..'&caption='..URL.escape(texto)
          end
          url = url .. '&reply_to_message_id=' .. msg.message_id..'&disable_web_page_preview=true'
          return sendRequest(url)
        end

        function api.sendDocument(chat_id, document, reply_to_message_id)
          local url = BASE_URL .. '/sendDocument'
          local curl_command = 'curl "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "document=@' .. document .. '"'
          if reply_to_message_id then
            curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
          end
          return curlRequest(curl_command)
        end

        function api.sendSticker(chat_id, sticker, reply_to_message_id)
          local url = BASE_URL .. '/sendSticker'
          local curl_command = 'curl "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "sticker=@' .. sticker .. '"'
          if reply_to_message_id then
            curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
          end
          return curlRequest(curl_command)
        end

        function api.sendStickerId(chat_id, file_id, reply_to_message_id)
          local url = BASE_URL .. '/sendSticker?chat_id=' .. chat_id .. '&sticker=' .. file_id
          if reply_to_message_id then
            url = url..'&reply_to_message_id='..reply_to_message_id
          end
          return sendRequest(url)
        end

        function api.sendAudio(chat_id, audio, reply_to_message_id, duration, performer, title)
          local url = BASE_URL .. '/sendAudio'
          local curl_command = 'curl "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "audio=@' .. audio .. '"'
          if reply_to_message_id then
            curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
          end
          if duration then
            curl_command = curl_command .. ' -F "duration=' .. duration .. '"'
          end
          if performer then
            curl_command = curl_command .. ' -F "performer=' .. performer .. '"'
          end
          if title then
            curl_command = curl_command .. ' -F "title=' .. title .. '"'
          end
          return curlRequest(curl_command)
        end

        function api.sendVideo(chat_id, video, reply_to_message_id, duration, performer, title)
          local url = BASE_URL .. '/sendVideo'
          local curl_command = 'curl "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "video=@' .. video .. '"'
          if reply_to_message_id then
            curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
          end
          if caption then
            curl_command = curl_command .. ' -F "caption=' .. caption .. '"'
          end
          if duration then
            curl_command = curl_command .. ' -F "duration=' .. duration .. '"'
          end
          return curlRequest(curl_command)
        end

        function api.sendVoice(chat_id, voice, reply_to_message_id)
          local url = BASE_URL .. '/sendVoice'
          local curl_command = 'curl "' .. url .. '" -F "chat_id=' .. chat_id .. '" -F "voice=@' .. voice .. '"'
          if reply_to_message_id then
            curl_command = curl_command .. ' -F "reply_to_message_id=' .. reply_to_message_id .. '"'
          end
          if duration then
            curl_command = curl_command .. ' -F "duration=' .. duration .. '"'
          end
          return curlRequest(curl_command)
        end

        function api.sendAdmin(text, format)
          return api.sendMessage(config.admin.owner, text, format)
        end

        function api.sendLog(text, format)
          return api.sendMessage(config.MDChat or config.admin.owner, text, format)
        end

        return api
