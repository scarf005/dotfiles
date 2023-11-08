{ config }:

let
  xdg = import ./xdg.nix { inherit config; };
in
xdg // {
  IDRIS2_PREFIX = "${xdg.XDG_DATA_HOME}/idris2";

  ANDROID_HOME = "${xdg.XDG_DATA_HOME}/android";

  ASDF_DATA_DIR = "${xdg.XDG_DATA_HOME}/asdf";
  ASDF_CONFIG_FILE = "${xdg.XDG_CONFIG_HOME}/asdf/asdfrc";

  AWS_SHARED_CREDENTIALS_FILE = "${xdg.XDG_CONFIG_HOME}/aws/credentials";
  AWS_CONFIG_FILE = "${xdg.XDG_CONFIG_HOME}/aws/config";

  _JAVA_OPTIONS = ''-Djava.util.prefs.userRoot="${xdg.XDG_CONFIG_HOME}"/java'';

  WORKON_HOME = "${xdg.XDG_DATA_HOME}/virtualenvs";
  WINEPREFIX = "${xdg.XDG_DATA_HOME}/wine";

  RUSTUP_HOME = "${xdg.XDG_DATA_HOME}/rustup";
  CARGO_HOME = "${xdg.XDG_DATA_HOME}/cargo";

  CRAWL_DIR = "${xdg.XDG_DATA_HOME}/crawl/";

  CUDA_CACHE_PATH = "${xdg.XDG_CACHE_HOME}/cuda";

  DISTCC_DIR = "${xdg.XDG_CONFIG_HOME}/distcc";
  DOCKER_CONFIG = "${xdg.XDG_CONFIG_HOME}/docker";

  GHCUP_USE_XDG_DIRS = "true";

  GNUPGHOME = "${xdg.XDG_DATA_HOME}/gnupg";
  GRADLE_USER_HOME = "${xdg.XDG_DATA_HOME}/gradle";
}
