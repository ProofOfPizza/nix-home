{
  enable = true;

  shellAbbrs = {
    cat = "bat";
    ls = "exa";

    v = "nvim";
    vim = "nvim";

    p = "gopass";
    ld = "ledger-default";
    r = "ranger";
    s = "sxiv";
    tma = "tmux attach -t";
    tmns = "tmux new-session -t";
    wet = "curl wttr.in";

    # Quick commands
    eled = "nvim ~/ledger/ledger.dat";
  };

  shellAliases = {
    tmux = "tmux -f ~/.config/tmux/tmux.conf";
  };

  promptInit = builtins.readFile ./prompt.fish;

  shellInit = ''
      set PATH (fd --absolute-path . $HOME/.config/scripts | tr '\n' ':' | sed 's/.$//') $PATH
      source ~/.ssh/environment > /dev/null
  '';

  interactiveShellInit = ''
    source $HOME/.config/fish/functions/fish_prompt.fish
    source $HOME/.config/fish/fzf-colors.fish
    bind \cb beginning-of-line
  '';
}
