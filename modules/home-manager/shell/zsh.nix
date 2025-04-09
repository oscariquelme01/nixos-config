{ pkgs, ... }: {
   programs.zsh = {
    enable = true;
    enableCompletion = true;
    
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      bindkey '^[0c' forward-word
      bindkey '^[0d' backward-word
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "sudo" ];
    };

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake .#topi";
    };
    history.size = 10000;
  };
}
