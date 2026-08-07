{
  description = "My NixOS configs";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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
    happ-nixos = {
      url = "github:MrShitFox/happ-nixos";
      flake = false;
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, lanzaboote, happ-nixos, zen-browser, ... }:
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
            home-manager.extraSpecialArgs = {
              inherit username;
              zenBrowser = zen-browser.packages.x86_64-linux.default;
            };
            home-manager.sharedModules = [];
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
        extraModules = [ "${happ-nixos}/happ-module.nix" ];
      };
      vm = mkHost {
        hostname = "vm";
        username = "user";
      };
    };
  };
}
