{ pkgs ? import <nixpkgs> { } }:

{
  ttc-sarasa-gothic-nerd-fonts = pkgs.callPackage ./ttc-sarasa-gothic-nerd-fonts { };
}
