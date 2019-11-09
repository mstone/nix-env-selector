const vscode = require('vscode')

exports.workspaceFoldersJs = _ => {
  const workspaceDirs = vscode.workspace.workspaceFolders
  return workspaceDirs ? workspaceDirs.map(dir => dir.uri.fsPath) : null
}

exports.getConfigurationJs = configPath => _ => {
  const config = vscode.workspace.getConfiguration()
  const value = config.get(configPath)
  return value === undefined ? null : value.toString()
}
