const vscode = require('vscode')

exports.showQuickPickJs = options => items =>
  vscode.window
    .showQuickPick(items, options)
    .then(value => (value === undefined ? null : value))
