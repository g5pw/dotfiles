# home.nix
{
  config,
  pkgs,
  ...
}: {
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

    ".config/nvim/" = {
      source = dotfiles/nvim;
      recursive = true;
    };

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

    ".gitconfig".source = dotfiles/git/config;
    ".gitignore".source = dotfiles/git/ignore;

    ".tclshrc".source = dotfiles/tclshrc;

    ".bash_aliases".source = dotfiles/bash/aliases;
    ".bash_profile".source = dotfiles/bash/profile;
    ".bashrc".source = dotfiles/bash/rc;

    ".config/erdtree/.erdtree.toml".source = dotfiles/erdtree.toml;

    # zsh {{{
    ".config/zsh/.p10k.zsh".source = dotfiles/zsh/p10k.zsh;

    ".config/zsh/.zprofile".source = dotfiles/zsh/profile;
    ".config/zsh/.zshenv".source = dotfiles/zsh/env;
    ".config/zsh/.zshrc".source = dotfiles/zsh/rc;
    ".config/zsh/_patches/remove-git-status.patch".source = dotfiles/zsh/_patches/remove-git-status.patch;
    ".config/zsh/functions/" = {
      source = dotfiles/zsh/functions;
      recursive = true;
    };
    ".config/zsh/zsh.d/" = {
      source = dotfiles/zsh/zsh.d;
      recursive = true;
    };
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
