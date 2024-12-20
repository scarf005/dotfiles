{ config, pkgs, pkgs-unstable, inputs, ... }:

let
  env = import ./env.nix { inherit config; };
  xdgDirs = import ./xdg.nix { inherit config; };

  sessionVariables = builtins.concatStringsSep "\n"
    (map (k: "set -gx ${k} ${env.${k}}") (builtins.attrNames env));
in
{
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://cache.nixos.org" "https://nixcache.reflex-frp.org" "https://digitallyinduced.cachix.org" ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
        "digitallyinduced.cachix.org-1:y+wQvrnxQ+PdEsCt91rmvv39qRCYzEgGQaldK26hCKE="
      ];
    };
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "scarf";
  home.homeDirectory = "/home/scarf";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (lib.getName pkg) [
  #     # Add additional package names here
  #     "vscode"
  #   ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    inputs.nil.packages.${pkgs.system}.default
    pkgs.nixpkgs-fmt

    # pkgs.vscode
    pkgs.helix

    pkgs.xdg-ninja
    pkgs.asdf-vm

    pkgs.numbat
    pkgs.sccache
    pkgs.lcov
    pkgs.yt-dlp
    pkgs.asciinema

    pkgs.traceroute
    pkgs.fastfetch

    pkgs-unstable.vlc
    pkgs-unstable.shellcheck
    pkgs-unstable.mold
    pkgs-unstable.bun
    pkgs-unstable.container2wasm

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
    "${env.PYTHONSTARTUP}".text = ''
      import os
      import atexit
      import readline

      history = os.path.join(os.environ['XDG_CACHE_HOME'], 'python_history')
      try:
          readline.read_history_file(history)
      except OSError:
          pass

      def write_history():
          try:
              readline.write_history_file(history)
          except OSError:
              pass

      atexit.register(write_history)
    '';

    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

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
  #  /etc/profiles/per-user/scarf/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  # home.sessionVariables = env;

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fish = {
      enable = true;
      shellAliases = import ./aliases.nix { inherit config; };
      loginShellInit = ''
      '';

      shellInit = ''
        ${sessionVariables}

        fish_add_path ${env.CARGO_HOME}/bin
        fish_add_path ${env.DENO_INSTALL}/bin
        fish_add_path ${xdgDirs.XDG_DATA_HOME}/pnpm

        source "$HOME/.nix-profile/share/asdf-vm/asdf.fish"

        zoxide init fish | source
        source $OMF_PATH/init.fish
      '';
    };
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };

  # i18n = {
  #   # defaultLocale = "ko_KR.UTF-8";
  #   inputMethod = {
  #     enabled = "kime";
  #     kime.config = {
  #       indicator.icon_color = "Black";
  #       addons = {
  #         all = [ ];
  #         dubeolsik = [ "TreatJongseongAsChoseong" ];
  #       };
  #     };
  #   };
  # };

  fonts.fontconfig.enable = true;
}
