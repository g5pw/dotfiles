{
  description = "Config for macos nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    superfile.url = "github:MHNightCat/superfile";
    superfile.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, superfile, home-manager }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        neo-cowsay
        lolcat
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
        # Spelling {{{
        enchant
        (hunspellWithDicts (with pkgs.hunspellDicts; [ it_IT en_US ]))
        (aspellWithDicts (d: [ d.it d.en d.en-computers d.en-science ]))
        # }}}
        bottom
        broot
        d2
        funzzy
        libqalculate
        mdcat
        ncdu
        nodePackages.mermaid-cli
        numbat
        pandoc
        pdfgrep
        pv
        skim
        wiki-tui
        wormhole-william
        yt-dlp
        # }}}

        # File Managers {{{
        xplr
        yazi
        superfile.packages.aarch64-darwin.default
        # }}}

        # Security/Encryption {{{
        _1password
        age
        diceware
        docker-credential-helpers
        gopass
        gnupg
        gpg-tui
        # }}}

        # jq-like parsers {{{
        fq
        fx
        gron
        htmlq
        jaq
        jc
        jql
        miller
        yq
        zed
        # }}}

        # coreutils replacements {{{
        bat
        eza
        fd
        ripgrep
        ripgrep-all
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
        navi
        qrencode
        redis
        skim
        sourceHighlight
        sqlite-utils
        tmux
        tree
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
        pulseview
        platformio
        (proxmark3.override {withGeneric = true;})
        # stlink
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
        oxker
        opentofu
        # }}}

        # Sysadmin tools {{{
        angle-grinder
        colima
        docker
        docker-compose
        docker-credential-helpers
        dogdns
        dstp
        fblog
        iperf
        jless
        htop
        gping
        mosh
        mtr
        nmap
        openssh
        podman
        pwgen
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
        difftastic
        diffsitter
        delta
        dprint
        #gdb
        gh
        gfold
        glab
        gitFull
        git-interactive-rebase-tool
        git-bug
        git-cliff
        git-brunch
        git-extras
        git-filter-repo
        git-latexdiff
        git-lfs
        gitui
        hexyl
        lazygit
        clang-analyzer
        clang-tools
        cmake
        doxygen
        editorconfig-core-c
        pre-commit
        rtags
        scmpuff
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
        bacon
        cargo-generate
        rustup
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
        rye
        # }}}
        # zig {{{
        # zig
        # zls
        # }}}
        nodePackages.js-beautify
        nodePackages.stylelint
        tectonic
        typst
        stylua
        nixfmt
        # }}}

        # Language servers {{{
        ccls
        # cmake-language-server broken
        nodePackages.bash-language-server
        yaml-language-server
        sqls
        terraform-ls
        statix
        # }}}

        nix-zsh-completions
        zsh-completions

        yubikey-manager
        yubikey-personalization
        openpgp-card-tools

        # pdfpc # marked as broken
        inkscape
        emacs-macport
        pinentry_mac
        qalculate-gtk
        zathura
        ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      nix.settings.trusted-substituters = ["https://devenv.cachix.org"];

      # Create /etc/zshrc that loads the nix-darwin environment.

      programs.zsh.enable = true;

      environment.etc.zshenv.text = "
        export ZDOTDIR=$HOME/.config/zsh
      ";

      nixpkgs.config.allowUnfree = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Configure Dock
      system.defaults.dock.autohide = true;
      system.defaults.dock.mru-spaces = false;
      system.defaults.dock.orientation = "bottom";

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#deepthought
    darwinConfigurations."deepthought" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration 
        home-manager.darwinModules.home-manager
        {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.g5pw = import ./home.nix;
            users.users.g5pw.home = "/Users/g5pw";

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."deepthought".pkgs;
  };
}
