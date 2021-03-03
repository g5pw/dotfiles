{ config, pkgs, ... }:

{

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToControl = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;
    [
      cowsay
      fortune
      gnupg
      gopass
      pandoc

      # Shell utils
      coreutils
      diffutils
      findutils
      inetutils
      moreutils
      patchutils


      bat
      broot
      exa
      fasd
      fd
      fzf
      gawk
      gh
      gitFull
      git-extras
      git-filter-repo
      git-latexdiff
      git-lfs
      git-hub
      gnused
      highlight
      jq
      lesspipe
      nnn
      qrencode
      rcm
      redis
      ripgrep
      sourceHighlight
      tig
      tmux
      turbogit
      youtube-dl
      zoxide
      zsh

      # Embedded tools
      avrdude
      dfu-util
      stm32flash
      openocd
      stlink

      # Sysadmin tools
      htop
      curlie
      kubectl
      kubernetes-helm
      minicom
      mosh
      mtr
      mycli
      nomad
      litecli
      pgcli
      nmap
      ncat
      sipcalc
      socat
      terraform
      vault

      # Development tools
      ansible
      ansible-lint
      black
      # clang-analyzer
      clang-tools
      cmake
      doxygen
      poetry
      python39Packages.ipython
      python39Packages.ptpython
      rtags
      shellcheck
      shfmt
      wiggle

      # Languages
      python39
      jupyter
      python39Packages.jupyterlab
      gnuplot_aquaterm

      # Language servers
      ccls
      cmake-language-server
      # python-language-server not supported
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      nodePackages.yaml-language-server
      gopls
      terraform-ls
      rls

      darwin-zsh-completions
      nix-zsh-completions
      zsh-completions

      yubikey-manager
      yubikey-personalization

      emacsMacport
      # pdfpc
      pinentry_mac
      qalculate-gtk
      wireshark-qt
      zathura
    ];


  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  services.emacs.enable = true;
  services.emacs.package = pkgs.emacsMacport;

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
      darwin-zsh-completions = super.runCommandNoCC "darwin-zsh-completions-0.0.0"
        { preferLocalBuild = true; }
        ''
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
  programs.zsh.enable = true;  # default shell on catalina
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

  users.nix.configureBuildUsers = true;

  # Configure Dock
  system.defaults.dock.autohide = true;
  system.defaults.dock.mru-spaces = false;
  system.defaults.dock.orientation = "bottom";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
