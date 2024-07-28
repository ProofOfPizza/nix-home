
{ config, lib, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "chai@adabtive.nl";
    userName = "Chai Stofkoper";
#    signing.key = "";
#    signing.signByDefault = true;
    extraConfig = {
    pull.rebase = true;
    fetch.prune = true;
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };
}
