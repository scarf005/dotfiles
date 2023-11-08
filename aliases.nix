{ config }:

let
  xdg = import ./xdg.nix { inherit config; };
in
{
  petite = "petite --eehistory ${xdg.XDG_DATA_HOME}/chezscheme/history";
  scheme = "scheme --eehistory ${xdg.XDG_DATA_HOME}/chezscheme/history";

  gdb = "gdb -n -x ${xdg.XDG_CONFIG_HOME}/gdb/init";
}
