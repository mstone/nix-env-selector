const vscode = require('vscode')

exports.createStatusJs = priority => alignment =>
  vscode.window.createStatusBarItem(alignment, priority)

exports.showStatus = text => maybeCommand => status => _ => {
  status.text = text
  status.command = maybeCommand || undefined
  status.show()
}

exports.hideStatus = status => () => {
  status.text = ''
  status.command = undefined
  status.hide()
}
