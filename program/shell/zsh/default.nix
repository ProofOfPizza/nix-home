{
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    autocd = true;
    defaultKeymap = "viins";
    history = {
      size = 1000;
      save = 1000;
      path = "./zsh_history";
     };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "docker"
        "git"
      ];	
    theme = "agnoster";
    };
}
