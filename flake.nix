{
  description = "NixOS + home-manager (dotfiles as input)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    android-nixpkgs = {
      url = "github:tadfisher/android-nixpkgs/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, android-nixpkgs, flake-utils, ... }@inputs:
let
  system = "x86_64-linux";
  overlays = [
    (final: prev: {
      linuxPackages_6_6 = prev.linuxPackages_6_6;  # Ensure kernel 6.6
      nvidia_x11 = final.linuxPackages_6_6.nvidia_x11.override { version = "470.256.02"; };
    })
  ];
  pkgs = import nixpkgs {
    inherit system;
    overlays = overlays;
    config.allowUnfree = true;
  };
    in
    {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs android-nixpkgs system;
          isNixOS = true;
          vars = import ./hosts/laptop/vars.nix;
        };
        modules = [
          ./hosts/laptop/host.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.liyan = import ./home/liyan/home.nix;
            home-manager.extraSpecialArgs = {
              isNixOS = true;
              vars = import ./home/liyan/vars.nix;
            };
          }
        ];
      };

      homeConfigurations = {
        "liyan@laptop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            isNixOS = true;
            vars = import ./home/liyan/vars.nix;
          };
          modules = [ ./home/liyan/home.nix ];
        };
        "liyan@debian" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            isNixOS = false;
            vars = import ./home/liyan/vars.nix;
          };
          modules = [ ./home/liyan/home.nix ];
        };
      };
    };
}
