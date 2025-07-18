# home.nix
{
  config,
  pkgs,
  nixgl,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "g5pw";
  home.homeDirectory = "/home/g5pw";

  nixpkgs.config.allowUnfree = true;

  nixGL.packages = import nixgl { inherit pkgs; };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    neo-cowsay
    dotacat
    fortune
    zellij

    # Editors {{{
    neovim
    # }}}

    # Shell utils {{{
    coreutils
    uutils-diffutils
    uutils-findutils
    cyme
    moreutils
    patchutils
    # }}}

    # Shells {{{
    # elvish
    nushell
    zsh
    # }}}

    # Productivity {{{
    bottom
    d2
    dust
    dysk
    fzf
    gawk
    gnused
    kalker
    mermaid-cli
    mprocs
    navi
    numbat
    pandoc
    procs
    pv
    scooter
    skim
    sshs
    sqlite-utils
    tabview
    television
    timewarrior
    unar
    usql
    watchexec
    wget
    wiki-tui
    xh
    yt-dlp
    zoxide
    zsh-abbr
    # }}}

    # Spelling {{{
    enchant
    (hunspell.withDicts (d: [d.it_IT d.en_US]))
    (aspellWithDicts (d: [d.it d.en d.en-computers d.en-science]))
    # }}}

    # Data tools {{{
    fq
    fx
    gron
    htmlq
    jaq
    jc
    jnv
    jql
    miller
    visidata
    xan
    # }}}

    # File Managers {{{
    broot
    erdtree
    xplr
    yazi
    # }}}

    # Security/Encryption {{{
    _1password-cli
    age
    diceware
    docker-credential-helpers
    gopass
    gnupg
    gpg-tui
    # }}}

    # coreutils replacements {{{
    bat
    eza
    fd
    funzzy
    ripgrep
    ripgrep-all
    viddy # A modern watch command. Time machine and pager etc.
    sd
    # }}}

    # Embedded tools {{{
    binwalk
    dfu-util
    dfu-programmer
    espup
    glasgow
    poke
    pulseview
    #platformio
    # stlink
    sigrok-cli
    tio
    # }}}

    # DevOps {{{
    ctop
    dive
    lazydocker
    k0sctl
    kubectl
    kubectl-explore
    kubernetes-helm
    k9s
    oxker
    opentofu
    # }}}

    # Sysadmin tools {{{
    angle-grinder
    btop
    colima
    #docker-client
    dogdns
    dstp
    fblog
    iperf
    jless
    gping
    nmap
    openssh
    podman
    pwgen
    rustcat
    sipcalc
    shelldap
    speedtest-rs
    socat
    solo2-cli
    sops
    trippy
    websocat
    wireshark
    # dbcli tools {{{
    mycli
    litecli
    pgcli
    # }}}
    # }}}

    # Development tools {{{
    ast-grep
    binsider
    cocogitto
    difftastic
    diffsitter
    delta
    devenv
    #gdb
    gh
    gfold
    glab
    gitFull
    git-interactive-rebase-tool
    git-brunch
    git-cliff
    git-extras
    git-filter-repo
    git-latexdiff
    git-lfs
    gitu
    gitui
    hexyl
    jira-cli-go
    jujutsu
    koji
    lazygit
    lazyjj
    mergiraf
    clang-analyzer
    clang-tools
    cmake
    doxygen
    pre-commit
    scmpuff
    serie
    srgn
    shellcheck
    wiggle
    just
    # }}}

    # HAM tools {{{
    hackrf
    # }}}

    llama-cpp

    # Languages {{{
    tree-sitter
    # lua {{{
    stylua
    lua-language-server
    # }}}
    # Javascript {{{
    nodejs
    # }}}
    # Markdown {{{
    glow # Markdown renderer
    presenterm
    # }}}
    # rust {{{
    bacon
    irust
    cargo-generate
    rustup
    rusty-man
    # }}}
    # go {{{
    delve
    go
    gomodifytags
    gotools
    gopls
    gore
    gotests
    golangci-lint
    # }}}
    # python {{{
    (let
      my-python-packages = python-packages:
        with python-packages; [
          ptpython
          jupyter
          pandas
          pip
          pyserial
          requests
          black
          pylint
          pyflakes
        ];
      python-with-my-packages = python3.withPackages my-python-packages;
    in
      python-with-my-packages)
    mypy
    ruff
    uv
    # }}}
    # typst {{{
    typst
    typstyle
    tinymist
    # }}}
    tectonic
    zig
    # }}}

    # Formatters {{{
    alejandra
    dockfmt
    nixfmt-rfc-style
    rstfmt
    shfmt
    sqlfluff
    # }}}

    # Language servers {{{
    bash-language-server
    yaml-language-server
    sqls
    terraform-ls
    texlab
    statix
    # }}}

    # TUIs {{{
    clipse
    cliflux
    nchat
    # }}}

    anyrun
    (config.lib.nixGL.wrap ghostty)
    (config.lib.nixGL.wrap neovide)
    iamb
    (config.lib.nixGL.wrap imhex)
    zathura
    (config.lib.nixGL.wrap zeal-qt6)
    #(config.lib.nixGL.wrap qutebrowser)
    pulseview
    xournalpp

    nix-zsh-completions
    zsh-completions

    yubikey-manager
    yubikey-personalization
    openpgp-card-tools

    nerd-fonts.fira-code
    nerd-fonts.monaspace

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (writeShellScriptBin "nxu" ''
      nix flake update --flake ~/.config/home-manager
    '')
    (writeShellScriptBin "nxa" ''
      home-manager switch
    '')
    (writeShellScriptBin "zeal_toggle" ''
      if swaymsg -t get_tree | jq -e '.. | select(.app_id?) | select(.app_id=="org.zealdocs.zeal")'; then
        swaymsg \[app_id="org.zealdocs.zeal"\] kill
      else
        zeal
      fi
    '')
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

    ".config/nvim" = {
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

    ".config/git/config".source = dotfiles/git/config;
    ".config/git/ignore".source = dotfiles/git/ignore;
    ".config/git/work".source = dotfiles/git/work;
    ".config/git/personal".source = dotfiles/git/personal;

    ".tclshrc".source = dotfiles/tclshrc;

    ".bash_aliases".source = dotfiles/bash/aliases;
    ".bash_profile".source = dotfiles/bash/profile;
    ".bashrc".source = dotfiles/bash/rc;

    ".config/erdtree/.erdtree.toml".source = dotfiles/erdtree.toml;

    ".config/sway" = {
      source = dotfiles/sway;
      recursive = true;
    };

    # zsh {{{
    ".config/zsh/.p10k.zsh".source = dotfiles/zsh/p10k.zsh;

    ".config/zsh/.zprofile".source = dotfiles/zsh/profile;
    ".config/zsh/.zshenv".source = dotfiles/zsh/env;
    ".config/zsh/.zshrc".source = dotfiles/zsh/rc;
    ".config/zsh/_patches/remove-git-status.patch".source = dotfiles/zsh/_patches/remove-git-status.patch;
    ".config/zsh/functions" = {
      source = dotfiles/zsh/functions;
      recursive = true;
    };
    ".config/zsh/zsh.d" = {
      source = dotfiles/zsh/zsh.d;
      recursive = true;
    };
    # }}}

    # gnupg {{{
    ".gnupg/dirmngr.conf".source = dotfiles/gnupg/dirmngr.conf;
    ".gnupg/scdaemon.conf".source = dotfiles/gnupg/scdaemon.conf;
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

  programs = {
    emacs.enable = true;

    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # Create /etc/zshrc that loads the nix-darwin environment.
    zsh.enable = true;
  };

  services = {
    emacs.enable = true;

    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      maxCacheTtl = 3600;
      defaultCacheTtl = 300;
    };
  };
}
