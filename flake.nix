{
  description = "NixOS + home-manager (dotfiles as input)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
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
      overlays = [ ];
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs android-nixpkgs system;
          isNixOS = true;  # For NixOS
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
              isNixOS = true;  # Pass to home-manager
              vars = import ./home/liyan/vars.nix;
            };
          }
        ];
      };

      homeConfigurations = {
        "liyan@laptop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            isNixOS = true;  # For consistency
            vars = import ./home/liyan/vars.nix;
          };
          modules = [ ./home/liyan/home.nix ];
        };

        "liyan@debian" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            isNixOS = false;  # For Debian
            vars = import ./home/liyan/vars.nix;
          };
          modules = [ ./home/liyan/home.nix ];
        };
      };
    };
}

# {
#   description = "NixOS + home-manager (dotfiles as input)";
#
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#     home-manager = {
#       url = "github:nix-community/home-manager";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#     android-nixpkgs = {
#       url = "github:tadfisher/android-nixpkgs/stable";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#     flake-utils.url = "github:numtide/flake-utils";
#   };
#
#   outputs = { self, nixpkgs, home-manager, android-nixpkgs, flake-utils, ... }@inputs:
#     let
#       system = "x86_64-linux";
#       overlays = [ ];
#       pkgs = import nixpkgs { 
#         inherit system overlays; 
#         config.allowUnfree = true;
#       };
#     in
#     {
#       nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
#         inherit system;
# 	specialArgs = {                 
#            inherit android-nixpkgs system inputs;
# 	   # specialArgs = { inherit inputs; };
#         };
#         modules = [
# 	  ./hosts/laptop/host.nix
# 	  # ./nix/modules/core/core.nix
# 	  home-manager.nixosModules.home-manager
# 	  {
# 	    home-manager.useGlobalPkgs = true;
# 	    home-manager.useUserPackages = true;
# 	    home-manager.users.liyan = import ./home/liyan/home.nix;
# 	  }
#         ];
#       };
#           # ==============================
#       # 2. Home Manager Configurations
#       # ==============================
#       homeConfigurations = {
#
#         "liyan@laptop" = home-manager.lib.homeManagerConfiguration {
#           inherit pkgs;
#           modules = [
#             ./home/liyan/home.nix
#           ];
#         };
#
#         "liyan@debian" = home-manager.lib.homeManagerConfiguration {
#           inherit pkgs;
#           modules = [
#             ./home/liyan/home.nix
#           ];
#         };
#      };
#   };
# }
