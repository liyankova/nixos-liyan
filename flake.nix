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
      # pkgs = nixpkgs.legacyPackages.${system}; 
#      dotfiles = /home/liyan/.dotfiles;
    in
    {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        inherit system;
	specialArgs = {                 
           inherit android-nixpkgs system inputs;
	   # specialArgs = { inherit inputs; };
        };
        modules = [
	  ./hosts/laptop/host.nix
	  # ./nix/modules/system/system-core.nix
	  # home-manager.nixosModules.home-manager
	  # {
	  #   home-manager.useGlobalPkgs = true;
	  #   home-manager.useUserPackages = true;
	  #   home-manager.users.liyan = import ./home/liyan/home.nix;
	  #        }
        ];
      

	#      homeConfigurations.liyan = home-manager.lib.homeManagerConfiguration {
	#        inherit pkgs;
	#        username = "liyan";
	#        homeDirectory = "/home/liyan";
	# stateVersion = "25.05";
	# modules = [
	#   ./home/home.nix
	# ];
	#      };
#  modules = [
#    ./home/liyan/home.nix         
#  ];
#  extraSpecialArgs = { inherit dotfiles; }; 
#      };
    };
          # ==============================
      # 2. Home Manager Configurations
      # ==============================
      homeConfigurations = {
        # Jalankan di NixOS atau Debian/Fedora/Arch (non-NixOS)
        "liyan@laptop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home/liyan/home.nix
          ];
        };

        # contoh lain kalau kamu install di Debian
        "liyan@debian" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home/liyan/home.nix
          ];
        };
      };
      };
}
