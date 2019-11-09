const vscode = require('vscode')

exports.showInformationMessage = message => _ =>
  vscode.window.showInformationMessage(message)
