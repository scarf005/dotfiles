{
  description = "Home Manager configuration of scarf";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, system-manager, ... } @ inputs:
    let
      inherit (self) outputs;
      # forEachSystem = nixpkgs.lib.genAttrs ["x86_64-linux"];
      # forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system} // import ./pkgs { inherit pkgs; };
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system} // import ./pkgs { inherit pkgs; };
    in
    {
      systemConfigs.default = system-manager.lib.makeSystemConfig {
        modules = [
          ./modules
        ];
      };

      homeConfigurations."scarf" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = { inherit inputs outputs pkgs-unstable; };
      };
    };
}
