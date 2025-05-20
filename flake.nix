{
  description = "Config for macos nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixos-wsl,
    nixpkgs,
    home-manager,
  }: let
    config_common = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        neo-cowsay
        dotacat
        fortune
        zellij

        # Editors {{{
        neovim
        # }}}

        # Shell utils {{{
        coreutils
        diffutils
        findutils
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
        pdfgrep
        procs
        pv
        skim
        serie
        sshs
        tabview
        sqlite-utils
        usql
        watchexec
        wget
        wiki-tui
        xh
        yt-dlp
        zoxide
        # }}}

        # Spelling {{{
        enchant
        (hunspellWithDicts (with pkgs.hunspellDicts; [it_IT en_US]))
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
        #esptool
        espup
        glasgow
        #openocd
        #pulseview
        #platformio
        # stlink
        tio
        # }}}

        # DevOps {{{
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
        btop
        colima
        docker-client
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
        git-extras
        git-filter-repo
        git-latexdiff
        git-lfs
        gitu
        gitui
        hexyl
        jujutsu
        lazygit
        clang-analyzer
        clang-tools
        cmake
        doxygen
        pre-commit
        scmpuff
        srgn
        shellcheck
        wiggle
        just
        # }}}

        # HAM tools {{{
        hackrf
        # }}}

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

        cliflux
        nchat

        neovide
        iamb
        imhex

        nix-zsh-completions
        zsh-completions

        yubikey-manager
        yubikey-personalization
        openpgp-card-tools
      ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      nix.settings.trusted-substituters = ["https://devenv.cachix.org"];
      nix.settings.trusted-public-keys = [
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];

      time.timeZone = "Europe/Rome";

      # Create /etc/zshrc that loads the nix-darwin environment.

      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };

      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.monaspace
      ];

      programs.zsh.enable = true;

      environment.etc.zshenv.text = "
        export ZDOTDIR=$HOME/.config/zsh
      ";

      nixpkgs.config.allowUnfree = true;
    };
    config_darwin = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        (proxmark3.override {withGeneric = true;})

        # pdfpc # marked as broken
        blueutil
        inkscape
        pinentry_mac
        sioyek
        zathura
        lagrange
      ];

      # nix.package = pkgs.nix;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Configure Dock
      system.defaults.dock.autohide = true;
      system.defaults.dock.mru-spaces = false;
      system.defaults.dock.orientation = "bottom";

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      nix.enable = true;

      ids.gids.nixbld = 30000;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
    config_nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        file
        distrobox
        unzip
        xdg-utils
      ];

      users.defaultUserShell = pkgs.zsh;

      nix.extraOptions = ''
         extra-substituters = https://devenv.cachix.org
         extra-trusted-public-keys =
      '';
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#deepthought
    darwinConfigurations."deepthought" = nix-darwin.lib.darwinSystem {
      modules = [
        config_common
        config_darwin

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

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        config_common
        config_nixos
        nixos-wsl.nixosModules.default
        {
          system.stateVersion = "24.11";
          wsl.enable = true;
          wsl.defaultUser = "g5pw";
          wsl.usbip.enable = true;
          i18n.supportedLocales = ["en_US.UTF-8/UTF-8" "it_IT.UTF-8/UTF-8"];
        }
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.g5pw = import ./home.nix;
        }
      ];
    };
  };
}
