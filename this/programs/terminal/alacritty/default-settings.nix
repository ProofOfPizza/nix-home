
{
  env = {
    "TERM" = "xterm-256color";
  };

  window = {
    opacity = 0.75;
    padding.x = 10;
    padding.y = 10;
    decorations = "full";
  };

  font = {
    size = 11.0;
    AppleFontSmoothing = true;

    normal.family = "Inconsolata-g for Powerline";
    bold.family = "Inconsolata-g for Powerline";
    italic.family = "Inconsolata-g for Powerline";
  };

  cursor.style = "Beam";

  shell = {
    program = "zsh";
  };

  colors = import ./colorschemes/nord.yml;
}
