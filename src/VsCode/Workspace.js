const vscode = require("vscode");

exports.workspaceFoldersJs = function() {
  const workspaceDirs = vscode.workspace.workspaceFolders;
  if (!workspaceDirs) {
    return null;
  }

  return workspaceDirs.map(function(dir) {
    return dir.uri.fsPath;
  });
};

exports.getConfigurationJs = function(configPath) {
  return function() {
    const config = vscode.workspace.getConfiguration();
    const value = config.get(configPath);
    return value === undefined ? null : value.toString();
  };
};
