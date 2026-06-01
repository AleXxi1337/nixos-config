{
  description = "My NixOS configs";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, ... }:
  let
    mkHost = { hostname, username, extraModules ? [] }:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = { inherit hostname username; };
        modules = [ 
          disko.nixosModules.disko
          ./hosts/${hostname}/disk-config.nix
          ./hosts/${hostname}/configuration.nix
          ./modules/common.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home/myuser.nix;
            home-manager.extraSpecialArgs = { inherit username; };
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
    };
  };
}
