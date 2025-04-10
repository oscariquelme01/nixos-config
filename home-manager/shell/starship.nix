{ ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      # Single line prompt
      add_newline = false;

      # A minimal left prompt
      format = "$directory$git_branch$git_status$character";

      # move the rest of the prompt to the right
      right_format = "$status$all";

      character = {
        success_symbol = "[❯](red)[❯](yellow)[❯](green)";
        error_symbol = "[❯](green)[❯](yellow)[❯](red)";
        vicmd_symbol = "[❮](green)[❮](yellow)[❮](red)";
      };

      git_branch = {
        format = "[󰘬 $branch]($style) ";
        style = "bold yellow";
      };

      python = {
        format = "(\\($virtualenv\\))";
      };

      git_status = {
        format = "$all_status$ahead_behind ";
        ahead = "[$count ⬆](bold purple) ";
        behind = "[$count ⬇](bold purple) ";
        staged = "[$count ✚](green) ";
        deleted = "[$count ✖](red) ";
        renamed = "[$count ➜](purple) ";
        stashed = "[$count 󰓎](cyan) ";
        untracked = "[$count ](white) ";
        modified = "[$count ](blue) ";
        conflicted = "[$count ═](yellow) ";
        diverged = "⇕ ";
        up_to_date = "";
      };

      directory = {
        style = "blue";
        format = "[   $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "";
        fish_style_pwd_dir_length = 1;
      };

      gradle = {
        format = "[  $version ]($style)";
      };

      java = {
        format = "[ ☕$version]($style)";
      };

      cmd_duration = {
        format = "[ $duration]($style) ";
      };

      line_break = {
        disabled = true;
      };

      package = {
        style = "bright-red";
        format = "[ $version]($style) ";
      };

      bun = {
        style = "bright-green";
        format = "[ $version]($style) ";
      };

      nodejs = {
        style = "green";
        format = "[ $version]($style) ";
        disabled = true;
      };

      status = {
        disabled = false;
        symbol = "✘ ";
      };

      custom.tmux = {
        format = "[   Tmux]($style)";
        when = ''
          if [ -z "$TMUX" ]; then
              exit 1  # Return false (non-zero exit code)
          else
              exit 0  # Return true (zero exit code)
          fi
        '';
        style = "bold cyan";
        disabled = false;
      };
    };
  };
}
