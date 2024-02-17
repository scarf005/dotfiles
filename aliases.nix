{ config }:

let
  xdg = import ./xdg.nix { inherit config; };
  aliases = with xdg; {
    petite = "petite --eehistory ${XDG_DATA_HOME}/chezscheme/history";
    scheme = "scheme --eehistory ${XDG_DATA_HOME}/chezscheme/history";

    gdb = "gdb -n -x ${XDG_CONFIG_HOME}/gdb/init";

    nvidia-settings = "nvidia-settings --config=${XDG_CONFIG_HOME}/nvidia/settings";

    svn = "svn --config-dir ${XDG_CONFIG_HOME}/subversion";
    wget = "wget --hsts-file=${XDG_DATA_HOME}/wget-hsts";
    irssi="irssi --config=${XDG_CONFIG_HOME}/irssi/config --home=${XDG_DATA_HOME}/irssi";
  };
in
aliases
