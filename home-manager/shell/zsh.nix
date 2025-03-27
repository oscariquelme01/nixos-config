{ pkgs, ... }: {
   programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = {
      ''
      bindkey "^[0c]" forward-word
      bindkey
      '';
    }

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake .#topi";
    };
    history.size = 10000;
  };
}
