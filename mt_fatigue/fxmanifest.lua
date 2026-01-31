fx_version 'cerulean'
game 'gta5'

author 'MTCore'
description 'AFK & Fatigue System'
version '1.1.0'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

ui_page 'nui/index.html'

files {
    'nui/*'
}
