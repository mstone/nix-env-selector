const vscode = require("vscode");

exports.createStatusJs = function(priority) {
  return function(alignment) {
    return vscode.window.createStatusBarItem(alignment, priority);
  };
};

exports.showStatus = function(text) {
  return function(maybeCommand) {
    return function(status) {
      return function() {
        status.text = text;
        status.command = maybeCommand || undefined;
        status.show();
      };
    };
  };
};

exports.hideStatus = function(status) {
  return function() {
    status.text = "";
    status.command = undefined;
    status.hide();
  };
};
