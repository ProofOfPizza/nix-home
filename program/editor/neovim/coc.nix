{ config }:
{
  tsserver.enable = true;
  tslint.configFile = "tslint.json";
  prettier.enable = true;
#  languageserver = {
#    golang = {
#      command = "go-langserver";
#      filetypes = [ "go" ];
#      initializationOptions = {
#        gocodeCompletionEnabled = true;
#        diagnosticsEnabled = true;
#        lintTool = "golint";
#      };
#    };
#  };
  python.pythonPath = "python3";
}
