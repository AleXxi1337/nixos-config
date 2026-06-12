{
  description = "My NixOS configs";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, lanzaboote, niri, ... }:
  let
    mkHost = { hostname, username, extraModules ? [] }:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = { inherit hostname username; };
        modules = [
          lanzaboote.nixosModules.lanzaboote
          disko.nixosModules.disko
          ./hosts/${hostname}/disk-config.nix
          ./hosts/${hostname}/configuration.nix
          ./modules/common.nix
          ./modules/base.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home/${username}.nix;
            home-manager.extraSpecialArgs = { inherit username; };
            home-manager.sharedModules = [ niri.homeModules.niri ];
          }
        ] ++ extraModules;
      };
  in
  {
    nixosConfigurations = {
      desktop = mkHost {
        hostname = "desktop";
        username = "user";
      };
      thinkpad = mkHost {
        hostname = "thinkpad";
        username = "user";
      };
      vm = mkHost {
        hostname = "vm";
        username = "user";
      };
    };
  };
}
