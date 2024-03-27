{ config }:

let
  xdg = import ./xdg.nix { inherit config; };
  env = with xdg; {
    IDRIS2_PREFIX = "${XDG_DATA_HOME}/idris2";
    PACK_DIR = "${XDG_DATA_HOME}/pack";

    ANDROID_HOME = "${XDG_DATA_HOME}/android";

    ASDF_DATA_DIR = "${XDG_DATA_HOME}/asdf";
    ASDF_DIR = "${XDG_DATA_HOME}/asdf"; # TODO: separate?
    ASDF_CONFIG_FILE = "${XDG_CONFIG_HOME}/asdf/asdfrc";
    ASDF_DIRENV_BIN = "${XDG_DATA_HOME}/asdf/plugins/direnv/bin";

    AWS_SHARED_CREDENTIALS_FILE = "${XDG_CONFIG_HOME}/aws/credentials";
    AWS_CONFIG_FILE = "${XDG_CONFIG_HOME}/aws/config";

    DENO_INSTALL = "${XDG_DATA_HOME}/deno";
    DENO_INSTALL_ROOT = "${XDG_DATA_HOME}/deno";

    DENO_DIR = "${XDG_CACHE_HOME}/deno";

    _JAVA_OPTIONS = ''-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java'';

    MINIKUBE_HOME = "${XDG_DATA_HOME}/minikube";

    WORKON_HOME = "${XDG_DATA_HOME}/virtualenvs";
    WINEPREFIX = "${XDG_DATA_HOME}/wine";

    RUSTUP_HOME = "${XDG_DATA_HOME}/rustup";
    CARGO_HOME = "${XDG_DATA_HOME}/cargo";

    CRAWL_DIR = "${XDG_DATA_HOME}/crawl/";
    GTK2_RC_FILES = "${XDG_CONFIG_HOME}/gtk-2.0/gtkrc";
    CUDA_CACHE_PATH = "${XDG_CACHE_HOME}/cuda";

    PARALLEL_HOME = "${XDG_CONFIG_HOME}/parallel";

    DISTCC_DIR = "${XDG_CONFIG_HOME}/distcc";
    DOCKER_CONFIG = "${XDG_CONFIG_HOME}/docker";

    GHCUP_USE_XDG_DIRS = "true";
    STACK_ROOT = "${XDG_DATA_HOME}/stack";

    GNUPGHOME = "${XDG_DATA_HOME}/gnupg";
    GRADLE_USER_HOME = "${XDG_DATA_HOME}/gradle";

    JUPYTER_CONFIG_DIR = "${XDG_CONFIG_HOME}/jupyter";

    KDEHOME = "${XDG_CONFIG_HOME}/kde";

    LESSHISTFILE = "${XDG_CACHE_HOME}/less/history";

    SQLITE_HISTORY = "${XDG_CACHE_HOME}/sqlite_history";
    SDKMAN_DIR = "${XDG_DATA_HOME}/sdkman";

    QT_QPA_PLATFORMTHEME = "kde";

    UNISON = "${XDG_DATA_HOME}/unison";

    ZDOTDIR = "${XDG_CONFIG_HOME}/zsh";
    PYTHONSTARTUP = "${XDG_CONFIG_HOME}/python/pythonrc";
  };
in
xdg // env
