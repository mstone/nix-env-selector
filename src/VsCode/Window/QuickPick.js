const vscode = require("vscode");

exports.showQuickPickJs = function(options) {
  return function(items) {
    var r = vscode.window.showQuickPick(items, options);
    
    return r.then(function(value) {
      console.log('result', value);
      return value === undefined ? null : value;
    })
  };
};
