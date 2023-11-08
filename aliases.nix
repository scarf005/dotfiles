{ config }:

let
  xdg = import ./xdg.nix { inherit config; };
  aliases = with xdg; {
    petite = "petite --eehistory ${XDG_DATA_HOME}/chezscheme/history";
    scheme = "scheme --eehistory ${XDG_DATA_HOME}/chezscheme/history";

    gdb = "gdb -n -x ${XDG_CONFIG_HOME}/gdb/init";

    nvidia-settings = "nvidia-settings --config=${XDG_CONFIG_HOME}/nvidia/settings";
  };
in
aliases
