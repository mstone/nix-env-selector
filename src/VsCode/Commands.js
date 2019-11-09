const vscode = require('vscode')

exports.registerCommand = command => callback => _ =>
  vscode.commands.registerCommand(command, callback)
