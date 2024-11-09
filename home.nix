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


    ".config/nvim/init.lua".source = dotfiles/nvim/init.lua;
    ".config/nvim/plugin/lastplace.lua".source = dotfiles/nvim/plugin/lastplace.lua;

    ".config/wezterm/wezterm.lua".source = dotfiles/wezterm/wezterm.lua;

    ".config/gitui/theme.ron".source = dotfiles/gitui/theme.ron;
    ".config/gitui/key_bindings.ron".source = dotfiles/gitui/key_bindings.ron;

    ".config/doom/packages.el".source = dotfiles/doom/packages.el;
    ".config/doom/config.el".source = dotfiles/doom/config.el;
    ".config/doom/init.el".source = dotfiles/doom/init.el;
    ".config/doom/hydras.el".source = dotfiles/doom/hydras.el;

    ".config/bat/config".source = dotfiles/bat/config;

    ".config/kitty/nord.conf".source = dotfiles/kitty/nord.conf;
    ".config/kitty/kitty.conf".source = dotfiles/kitty/kitty.conf;

    ".config/helix/config.toml".source = dotfiles/helix/config.toml;

    ".digrc".source = dotfiles/digrc;
    ".gdbinit".source = dotfiles/gdbinit;
    ".Xresources".source = dotfiles/Xresources;
    ".profile".source = dotfiles/profile;
    ".npmrc".source = dotfiles/npmrc;
    ".octaverc".source = dotfiles/octaverc;
    ".iftoprc".source = dotfiles/iftoprc;
    ".inputrc".source = dotfiles/inputrc;
    ".psqlrc".source = dotfiles/psqlrc;
    ".ideavimrc".source = dotfiles/ideavimrc;

    ".gitconfig".source = dotfiles/gitconfig;
    ".gitignore".source = dotfiles/gitignore;

    ".tclshrc".source = dotfiles/tclshrc;

    ".bash_aliases".source = dotfiles/bash/aliases;
    ".bash_profile".source = dotfiles/bash/profile;
    ".bashrc".source = dotfiles/bash/rc;

    ".config/erdtree/.erdtree.toml".source = dotfiles/erdtree.toml;

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
    ".config/zsh/functions/_whichf".source = dotfiles/zsh/functions/_whichf;
    ".config/zsh/functions/_xattr".source = dotfiles/zsh/functions/_xattr;
    ".config/zsh/functions/acronym".source = dotfiles/zsh/functions/acronym;
    ".config/zsh/functions/alert".source = dotfiles/zsh/functions/alert;
    ".config/zsh/functions/aping".source = dotfiles/zsh/functions/aping;
    ".config/zsh/functions/bat_status".source = dotfiles/zsh/functions/bat_status;
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
    ".config/zsh/zsh.d/31_aliases.zsh".source = dotfiles/zsh/zsh.d/31_aliases_mac.zsh;
    ".config/zsh/zsh.d/50_plugin.zsh".source = dotfiles/zsh/zsh.d/50_plugin.zsh;
    ".config/zsh/zsh.d/50_utils.zsh".source = dotfiles/zsh/zsh.d/50_utils.zsh;
    ".config/zsh/zsh.d/80_bindings.zsh".source = dotfiles/zsh/zsh.d/80_bindings.zsh;
    ".config/zsh/zsh.d/90_fzf.zsh".source = dotfiles/zsh/zsh.d/90_fzf.zsh;
    ".config/zsh/zsh.d/90_prompt.zsh".source = dotfiles/zsh/zsh.d/90_prompt.zsh;
    ".config/zsh/zsh.d/91_autosuggestions.zsh".source = dotfiles/zsh/zsh.d/91_autosuggestions.zsh;
    ".config/zsh/zsh.d/91_fzf-widgets.zsh".source = dotfiles/zsh/zsh.d/91_fzf-widgets.zsh;
    ".config/zsh/zsh.d/93_git.zsh".source = dotfiles/zsh/zsh.d/93_git.zsh;
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

