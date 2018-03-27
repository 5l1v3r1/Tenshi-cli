shell       = require 'shelljs'
prompt      = require 'prompt'
sudo        = require 'sudo-prompt'
prompts     = require './prompts.coffee'
colors      = require 'colors/safe'
fs          = require 'fs'
path        = require 'path'
homedir     = require('os').homedir()
tenshidir   = path.join(homedir, 'tenshi')


TinstallCheck = ->
  if !fs.existsSync(tenshidir)
    console.log ' '
    console.log colors.green(':: Installing Tenshii-chan ::')
    console.log ' '
    shell.cd homedir
    shell.exec 'git clone git://github.com/VNBot-Developers/Tenshi.git'
    return firstTimeSetupTenshi()
  checkForUpdates false

checkForUpdates = (comingFromInstall) ->
  typebot = require "#{tenshidir}/config.json"
  console.log colors.green(':: Checking for updates ::')
  if comingFromInstall
    console.log ' '
    console.log colors.green(':: Tenshi has been installed to ' + tenshidir + ' ::')
  shell.cd tenshidir
  shell.exec 'git pull'
  console.log ' '
  console.log colors.green(':: Almost Finish <3 ::')
  shell.exec 'npm update'
  if typebot.type is "self"
    shell.exec 'npm start'
  else if typebot.type is "group"
    shell.exec 'npm run group'
  else
    shell.exec 'npm start'
  return

firstTimeSetupTenshi = ->
  console.log colors.green(':: Installing dependencies ::')
  shell.cd tenshidir
  shell.exec 'npm install'
  prompt.start()
  prompt.message = ''
  console.log ' '
  console.log colors.green(':: Let\'s configure Tenshi-chan ::')
  console.log ' '
  prompt.get prompts, (err, result) ->
    if err
      console.error err
      return process.exit(1)
    if result.confirm == 'yes' or result.confirm == 'y'
      return buildConfigFile(result)
    console.log ' '
    console.log colors.red(':: Your data not save, please run this tool again or edit config file by hand ::')
    process.exit()
  return
buildConfigFile = (result) ->
  config =
    username: result.username
    password: result.password
    type: result.type
    prefix: result.prefix
  fs.writeFile path.join(tenshidir, 'config.json'), JSON.stringify(config, null, '\u0009'), 'utf-8', (err) ->
    if err
      throw err
    console.log ' '
    console.log colors.green(':: Tenshi setup is done ::')
    checkForUpdates true
  return


shell.cd path.resolve(process.cwd())
TinstallCheck()
