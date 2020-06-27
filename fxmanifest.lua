fx_version "adamant"

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game "rdr3"

client_script 'compass.lua'
ui_page 'compass.html'

files {
  'compass.html',
}
exports {
    'showCompass',
    'hideCompass'
}
