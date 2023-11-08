{ config }:

let
  HOME = config.home.homeDirectory;
in
{
  XDG_STATE_HOME = "${HOME}/.local/state";
  XDG_CACHE_HOME = "${HOME}/.cache";
  XDG_DATA_HOME = "${HOME}/.local/share";
  XDG_CONFIG_HOME = "${HOME}/.config";
  XDG_BIN_HOME = "${HOME}/.local/bin";
}
