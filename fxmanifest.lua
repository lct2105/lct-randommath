fx_version 'cerulean'
game 'gta5'

description 'LCT-RANDOMMATH'
version '1.0.0'


client_script {
    'config.lua',
    'client.lua',
}


server_script {
    'config.lua',
    'server.lua'
}

lua54 'yes'

ui_page 'html/ui.html'

files {
	'html/ui.html',
	'html/main.css',
	'html/app.js',
}
 