* * *

                 ____       _                ____  _
                |  _ \ ___ | |__   ___      |  _ \| |__  
                | |_) / _ \| '_ \ / _ \     | | | | '_ \
                |  _ < (_) | |_) | (_) |    | |_| | |_) |  By: Vycktor Stark
                |_| \_\___/|_.__/ \___/     |____/|_.__/   Version: 2.0

                
* * *

## Getting Started

These instructions will give you a copy of the project for you to use for development and testing purposes.

## What is it?

Robot Db is a **Fork** that uses a Telegram API written in Lua. Its structure was made from the master [Otouto](https://github.com/topkecleon/otouto) [v3.1](https://github.com/topkecleon/otouto/tree/26c1299374af130bbf8457af904cb4ea450caa51) ([@mokubot](https://telegram.me/mokubot)) And it is based on plugin of it. This makes it easier to manage bot function and command and allows you to split the bot's different capabilities into different files for a more specific view of what to do based on the **Ed Project** made by synko developers and [SiD](https://github.com/TiagoDanin/SiD) made by [Tiago Danin](https://github.com/TiagoDanin).

* * *

## Configuring bot

You must have your machine updated, and have Lua (5.2+) installed, in addition to some modules: LuaSocket, LuaSec, Redis-Lua, Lua term and Lua serpent. And, to upload files, you need to have them installed as well.

What you need to install and use the project:

```
# Tested on Ubuntu 14.04, 15.04 and 16.04, Debian 7, Linux Mint 17.2
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo apt-get install libreadline-dev libssl-dev lua5.2 liblua5.2-dev git make unzip redis-server curl libcurl4-gnutls-dev
$ sudo apt install lua5.2 luarocks liblua5.2-dev lua-sec lua-socket xtitle curl deborphan figlet libreadline-dev libconfig-dev libssl-dev  libevent-dev make unzip git redis-server g++ libjansson-dev libpython-dev expat libexpat1-dev -f -y
$ sudo apt-get install figlet
# We are going now to install LuaRocks and the required Lua modules

$ wget http://keplerproject.github.io/luarocks/releases/luarocks-2.3.0.tar.gz
$ tar zxpf luarocks-2.3.0.tar.gz
$ cd luarocks-2.3.0
$ ./configure; sudo make bootstrap
$ sudo luarocks install luasec
$ sudo luarocks install luasocket
$ sudo luarocks install redis-lua
$ sudo luarocks install lua-term
$ sudo luarocks install serpent
$ sudo luarocks install dkjson
$ sudo luarocks install Lua-cURL
$ sudo luarocks install luautf8
$ sudo luarocks install multipart-post
$ cd ..

```

Install Curl, only if you need:

```bash
$ sudo apt-get install curl
```

Cloning the repository:

```bash
# Cloning the repository and giving the permissions to start the initiation script

$ git clone https://github.com/VycktorStark/DbRobot-Lua.git
$ cd DbRobot/Adicional && sudo chmod 777 Iniciar.sh && ./Iniciar.sh
```

**First of all, take a look at your bot settings:**

> • Make sure privacy is off (more information on the [Bots official FAQ page](https://core.telegram.org/bots/faq#what-messages-will-my-bot-get)). Send `/setprivacy` for [BotFather](http://telegram.me/BotFather) To check the current setting.

**Before doing anything, open the DataConfig folder, and then open the Config-All folder and a text editor and make the following changes to the config.lua file:**

> • Set your Telegram ID to admin (in the `admin.owner` field and in the `admin.admins` field, as a table element with `true` replace with the ids of your admins).
>
> •  You can create a logging group where error messages are sent: this allows you to share user feedback errors. Replace the current ID in the `MDChat` paramts with the designed group id, otherwise remove a line to avoid errors when starting the bot.
>
> • Set your bot channel (if you have one) in the config.lua, in the `channel` field. You should add the bot as the channel administrator if you want to post something with it.
>

**And, then still with open text editor also make the following changes in the APIs.lua file:**

> • Set `ApiBot` with the authentication token received from the [BotFather](http://telegram.me/BotFather).
>
> • Set `AI` to the token of your simsimi project, if you do not create one on [© SimSimi Inc](http://developer.simsimi.com/) and pay for it every month.
>
> •  If it prompts for a password during / after an installation, enter your machine sudo password.
>
* * *


## Initialization process

To start the bot, execute `./DbRobot/Adicional/Iniciar.sh`. To stop the bot, press `Ctrl + c` twice.

You can also start the bot with `cd Bot && lua Bot.lua`, but then it will not restart automatically.

* * *

## Dedication

I dedicate my sincere credits to the [Drew](https://github.com/topkecleon),  creator of Otouto who started this project. And for the [RememberTheAir](https://github.com/RememberTheAir) creator of GroupButler, and for the [Wesley Henrique](https://github.com/Synk0), and for the [Tiago Danin](https://github.com/tiagodanin), for  the **Marcos Ferreira** and [Adilson Cavalcante](https://github.com/Player4NoobWinner). :p

* * *

## [@DbRobot](telegram.me/DbRobot)
