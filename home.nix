# home.nix

{ config, pkgs, ... }:

{

  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    

    ".pythonrc".source = dotfiles/pythonrc;
    ".orpierc".source = dotfiles/orpierc;


    ".config/nvim/init.lua".source = dotfiles/config/nvim/init.lua;
    ".config/nvim/plugin/lastplace.lua".source = dotfiles/config/nvim/plugin/lastplace.lua;

    ".config/wezterm/wezterm.lua".source = dotfiles/config/wezterm/wezterm.lua;

    ".config/gitui/theme.ron".source = dotfiles/config/gitui/theme.ron;
    ".config/gitui/key_bindings.ron".source = dotfiles/config/gitui/key_bindings.ron;

    ".config/doom/packages.el".source = dotfiles/config/doom/packages.el;
    ".config/doom/config.el".source = dotfiles/config/doom/config.el;
    ".config/doom/init.el".source = dotfiles/config/doom/init.el;
    ".config/doom/hydras.el".source = dotfiles/config/doom/hydras.el;

    ".config/bat/config".source = dotfiles/config/bat/config;

    ".config/kitty/nord.conf".source = dotfiles/config/kitty/nord.conf;
    ".config/kitty/kitty.conf".source = dotfiles/config/kitty/kitty.conf;

    ".config/helix/config.toml".source = dotfiles/config/helix/config.toml;

    ".tmux.conf".source = dotfiles/tmux.conf;
    ".digrc".source = dotfiles/digrc;
    ".gdbinit".source = dotfiles/gdbinit;
    ".Xresources".source = dotfiles/Xresources;
    ".profile".source = dotfiles/profile;
    ".npmrc".source = dotfiles/npmrc;
    ".octaverc".source = dotfiles/octaverc;
    ".iftoprc".source = dotfiles/iftoprc;
    ".inputrc".source = dotfiles/inputrc;
    ".latexmkrc".source = dotfiles/latexmkrc;
    ".psqlrc".source = dotfiles/psqlrc;
    ".ideavimrc".source = dotfiles/ideavimrc;

    ".gitconfig".source = dotfiles/gitconfig;
    ".gitignore".source = dotfiles/gitignore;

    ".tclshrc".source = dotfiles/tclshrc;

    ".bash_aliases".source = dotfiles/bash_aliases;
    ".bash_profile".source = dotfiles/bash_profile;
    ".bashrc".source = dotfiles/bashrc;

    ".config/erdtree/.erdtree.toml".source = dotfiles/config/erdtree.toml;

    # zsh {{{
    ".config/zsh/.p10k.zsh".source = dotfiles/zsh/p10k.zsh;

    ".config/zsh/.zprofile".source = dotfiles/zsh/zprofile;
    ".config/zsh/.zshenv".source = dotfiles/zsh/zshenv;
    ".config/zsh/.zshrc".source = dotfiles/zsh/zshrc;

    ".config/zsh/_patches/remove-git-status.patch".source = dotfiles/zsh/_patches/remove-git-status.patch;
    ".config/zsh/functions/_defaults".source = dotfiles/zsh/functions/_defaults;
    ".config/zsh/functions/_hdiutil".source = dotfiles/zsh/functions/_hdiutil;
    ".config/zsh/functions/_launchctl".source = dotfiles/zsh/functions/_launchctl;
    ".config/zsh/functions/_mdattr".source = dotfiles/zsh/functions/_mdattr;
    ".config/zsh/functions/_mdfind".source = dotfiles/zsh/functions/_mdfind;
    ".config/zsh/functions/_mdls".source = dotfiles/zsh/functions/_mdls;
    ".config/zsh/functions/_mdutil".source = dotfiles/zsh/functions/_mdutil;
    ".config/zsh/functions/_poetry".source = dotfiles/zsh/functions/_poetry;
    ".config/zsh/functions/_whichf".source = dotfiles/zsh/functions/_whichf;
    ".config/zsh/functions/_xattr".source = dotfiles/zsh/functions/_xattr;
    ".config/zsh/functions/acronym".source = dotfiles/zsh/functions/acronym;
    ".config/zsh/functions/alert".source = dotfiles/zsh/functions/alert;
    ".config/zsh/functions/aping".source = dotfiles/zsh/functions/aping;
    ".config/zsh/functions/bat_status".source = dotfiles/zsh/functions/bat_status;
    ".config/zsh/functions/battery".source = dotfiles/zsh/functions/battery;
    ".config/zsh/functions/box".source = dotfiles/zsh/functions/box;
    ".config/zsh/functions/checksum".source = dotfiles/zsh/functions/checksum;
    ".config/zsh/functions/colortable".source = dotfiles/zsh/functions/colortable;
    ".config/zsh/functions/ediff".source = dotfiles/zsh/functions/ediff;
    ".config/zsh/functions/edit_function".source = dotfiles/zsh/functions/edit_function;
    ".config/zsh/functions/fliptable".source = dotfiles/zsh/functions/fliptable;
    ".config/zsh/functions/mcd".source = dotfiles/zsh/functions/mcd;
    ".config/zsh/functions/mdattr".source = dotfiles/zsh/functions/mdattr;
    ".config/zsh/functions/named_dirs".source = dotfiles/zsh/functions/named_dirs;
    ".config/zsh/functions/pomo".source = dotfiles/zsh/functions/pomo;
    ".config/zsh/functions/readme".source = dotfiles/zsh/functions/readme;
    ".config/zsh/functions/reload".source = dotfiles/zsh/functions/reload;
    ".config/zsh/functions/rtab".source = dotfiles/zsh/functions/rtab;
    ".config/zsh/functions/spectrum".source = dotfiles/zsh/functions/spectrum;
    ".config/zsh/functions/src".source = dotfiles/zsh/functions/src;
    ".config/zsh/functions/trac-get".source = dotfiles/zsh/functions/trac-get;
    ".config/zsh/functions/trac-patch".source = dotfiles/zsh/functions/trac-patch;
    ".config/zsh/functions/whichf".source = dotfiles/zsh/functions/whichf;

    ".config/zsh/zsh.d/00_zinit.zsh".source = dotfiles/zsh/zsh.d/00_zinit.zsh;
    ".config/zsh/zsh.d/01_prompt.zsh".source = dotfiles/zsh/zsh.d/01_prompt.zsh;
    ".config/zsh/zsh.d/10_options.zsh".source = dotfiles/zsh/zsh.d/10_options.zsh;
    ".config/zsh/zsh.d/11_ls_colors_256.zsh".source = dotfiles/zsh/zsh.d/11_ls_colors_256.zsh;
    ".config/zsh/zsh.d/15_autoload.zsh".source = dotfiles/zsh/zsh.d/15_autoload.zsh;
    ".config/zsh/zsh.d/19_hosts.zsh".source = dotfiles/zsh/zsh.d/19_hosts.zsh;
    ".config/zsh/zsh.d/20_completion.zsh".source = dotfiles/zsh/zsh.d/20_completion.zsh;
    ".config/zsh/zsh.d/21_compdefs.zsh".source = dotfiles/zsh/zsh.d/21_compdefs.zsh;
    ".config/zsh/zsh.d/25_scmpuff.zsh".source = dotfiles/zsh/zsh.d/25_scmpuff.zsh;
    ".config/zsh/zsh.d/30_aliases.zsh".source = dotfiles/zsh/zsh.d/30_aliases.zsh;
    ".config/zsh/zsh.d/31_aliases.zsh".source = dotfiles/tag-mac/zsh/zsh.d/31_aliases.zsh;
    ".config/zsh/zsh.d/50_plugin.zsh".source = dotfiles/zsh/zsh.d/50_plugin.zsh;
    ".config/zsh/zsh.d/50_utils.zsh".source = dotfiles/zsh/zsh.d/50_utils.zsh;
    ".config/zsh/zsh.d/80_bindings.zsh".source = dotfiles/zsh/zsh.d/80_bindings.zsh;
    ".config/zsh/zsh.d/90_fzf.zsh".source = dotfiles/zsh/zsh.d/90_fzf.zsh;
    ".config/zsh/zsh.d/90_prompt.zsh".source = dotfiles/zsh/zsh.d/90_prompt.zsh;
    ".config/zsh/zsh.d/91_autosuggestions.zsh".source = dotfiles/zsh/zsh.d/91_autosuggestions.zsh;
    ".config/zsh/zsh.d/91_fzf-widgets.zsh".source = dotfiles/zsh/zsh.d/91_fzf-widgets.zsh;
    ".config/zsh/zsh.d/93_git.zsh".source = dotfiles/zsh/zsh.d/93_git.zsh;
    ".config/zsh/zsh.d/97_tmux.zsh".source = dotfiles/zsh/zsh.d/97_tmux.zsh;
    ".config/zsh/zsh.d/99_term-integrations.zsh".source = dotfiles/zsh/zsh.d/99_term-integrations.zsh;
    ".config/zsh/zsh.d/99_cleanup.zsh".source = dotfiles/zsh/zsh.d/99_cleanup.zsh;
    # }}}

    # gnupg {{{
    ".gnupg/dirmngr.conf".source = dotfiles/gnupg/dirmngr.conf;
    ".gnupg/scdaemon.conf".source = dotfiles/gnupg/scdaemon.conf;
    ".gnupg/gpg-agent.conf".source = dotfiles/gnupg/gpg-agent.conf;
    ".gnupg/gpg.conf".source = dotfiles/gnupg/gpg.conf;
    # }}}

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/davish/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}

