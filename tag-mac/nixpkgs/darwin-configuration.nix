# vim: foldmethod=marker
{ config, pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    (import (fetchTarball
      "https://github.com/cachix/devenv/archive/v0.6.3.tar.gz")).default
    cowsay
    fortune
    zellij

    # Editors {{{
    helix
    neovim
    # }}}

    # Shell utils {{{
    coreutils
    diffutils
    findutils
    #inetutils
    moreutils
    patchutils
    # }}}

    # Shells {{{
    # elvish
    # nushell
    zsh
    # }}}

    # Productivity {{{
    # Spelling {{{
    enchant
    (hunspellWithDicts (with pkgs.hunspellDicts; [ it-it en-us sl ]))
    (aspellWithDicts (d: [ d.it d.en d.en-computers d.en-science ]))
    # }}}
    bcal
    d2
    #calc
    funzzy
    libqalculate
    mdcat
    miller
    pandoc
    pdfgrep
    skim
    wormhole-william
    yazi
    yt-dlp
    wiki-tui
    nodePackages.mermaid-cli
    # }}}

    # Security/Encryption {{{
    _1password
    age
    diceware
    docker-credential-helpers
    gopass
    git-credential-gopass
    git-credential-1password
    gnupg
    gpg-tui
    # }}}

    # jq-like parsers {{{
    htmlq
    jq
    jc
    fx
    fq
    yq
    zed
    # }}}

    # coreutils replacements {{{
    bat
    eza
    fd
    ripgrep
    #ripgrep-all fails testing
    viddy
    # }}}

    # Misc {{{
    direnv
    dos2unix
    fzf
    gawk
    gnused
    grc
    highlight
    lesspipe
    mprocs
    qrencode
    rcm
    redis
    skim
    sourceHighlight
    sqlite-utils
    tmux
    tree
    turbogit
    usql
    unixtools.watch
    watchexec
    wget
    xh
    zoxide
    # }}}

    # Embedded tools {{{
    avrdude
    binwalk
    dfu-util
    dfu-programmer
    dtc
    esptool
    espup
    minicom
    stm32flash
    openocd
    stlink
    gcc-arm-embedded
    tio
    # }}}

    # DevOps {{{
    ansible
    ansible-lint
    ctop
    dive
    lazydocker
    k0sctl
    kubectl
    kube3d
    kubernetes-helm
    k9s
    # nomad
    terraform
    vault
    # }}}

    # Sysadmin tools {{{
    bettercap
    colima
    docker
    docker-compose
    dogdns
    dstp
    fblog
    gvproxy # needed for podman-machine
    iperf
    #ipv6calc # unsupported
    jless
    htop
    # gping # unsupported
    mosh
    mtr
    nmap
    openssh
    podman
    pwgen
    sipcalc
    #shelldap # unsupported
    speedtest-rs
    socat
    solo2-cli
    sops
    trippy
    websocat
    # dbcli tools {{{
    mycli
    litecli
    pgcli
    # }}}
    # }}}

    # Development tools {{{
    ast-grep
    delta
    dprint
    gh
    gfold
    glab
    gitFull
    git-interactive-rebase-tool
    git-bug
    # git-brunch marked as broken
    git-extras
    git-filter-repo
    git-latexdiff
    git-lfs
    gitui
    hexyl
    tig
    clang-analyzer
    clang-tools
    cmake
    doxygen
    editorconfig-core-c
    pre-commit
    rtags
    shellcheck
    shfmt
    wiggle
    just
    # }}}

    # HAM tools {{{
    hackrf
    # }}}

    # Languages {{{
    tree-sitter
    # Javascript {{{
    bun
    nodejs
    # }}}
    glow # Markdown renderer
    # rust {{{
    rustup
    bacon
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
          isort
          nose
          pipx
          pylint
          pyflakes
          pytest
        ];
      python-with-my-packages = python3.withPackages my-python-packages;
    in python-with-my-packages)
    mypy
    ruff
    nodePackages.pyright
    # }}}
    # zig {{{
    # zig
    # zls
    # }}}
    nodePackages.js-beautify
    nodePackages.stylelint
    tectonic
    stylua
    nixfmt
    m-cli
    # }}}

    # Language servers {{{
    ccls
    # cmake-language-server broken
    nodePackages.bash-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    sqls
    terraform-ls
    statix
    # }}}

    darwin-zsh-completions
    nix-zsh-completions
    zsh-completions

    yubikey-manager4
    yubikey-personalization

    # pdfpc # marked as broken
    emacsMacport
    pinentry_mac
    qalculate-gtk
    zathura
  ];

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # services.emacs.enable = true;
  # services.emacs.package = pkgs.emacsMacport;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override {
        viAlias = true;
        vimAlias = true;
      };
      darwin-zsh-completions = super.runCommand "darwin-zsh-completions-0.0.0" {
        preferLocalBuild = true;
      } ''
        mkdir -p $out/share/zsh/site-functions
        cat <<-'EOF' > $out/share/zsh/site-functions/_darwin-rebuild
        #compdef darwin-rebuild
        #autoload
        _nix-common-options
        local -a _1st_arguments
        _1st_arguments=(
          'switch:Build, activate, and update the current generation'\
          'build:Build without activating or updating the current generation'\
          'check:Build and run the activation sanity checks'\
          'changelog:Show most recent entries in the changelog'\
        )
        _arguments \
          '--list-generations[Print a list of all generations in the active profile]'\
          '--rollback[Roll back to the previous configuration]'\
          {--switch-generation,-G}'[Activate specified generation]'\
          '(--profile-name -p)'{--profile-name,-p}'[Profile to use to track current and previous system configurations]:Profile:_nix_profiles'\
          '1:: :->subcmds' && return 0
        case $state in
          subcmds)
            _describe -t commands 'darwin-rebuild subcommands' _1st_arguments
          ;;
        esac
        EOF
      '';
    })
  ];

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;
  programs.zsh.enableBashCompletion = true;
  programs.zsh.enableFzfCompletion = true;
  programs.zsh.enableFzfGit = true;
  programs.zsh.enableFzfHistory = true;

  environment.loginShell = "${pkgs.zsh}/bin/zsh -l";
  environment.variables.SHELL = "${pkgs.zsh}/bin/zsh";
  environment.variables.EDITOR = "nvim";
  environment.variables.LANG = "it_IT.UTF-8";
  environment.variables.LC_MESSAGES = "en_US.UTF-8";
  environment.shells = [ pkgs.zsh pkgs.bash ];

  nix.configureBuildUsers = true;

  # Configure Dock
  system.defaults.dock.autohide = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.orientation = "bottom";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
