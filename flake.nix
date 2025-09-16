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
 #   dotfiles.url = "github:liyankova/wallust-dotfiles";
  };

  outputs = { self, nixpkgs, home-manager, android-nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system}; 
#      dotfiles = /home/liyan/.dotfiles;
    in
    {
      nixosConfigurations.liyan = nixpkgs.lib.nixosSystem {
        inherit system;
	specialArgs = {                 
           inherit android-nixpkgs;
        };
        modules = [
	  ./hosts/default
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.liyan = import ./home;
          }
        ];
      };

      homeConfigurations.liyan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        username = "liyan";
        homeDirectory = "/home/liyan";
	stateVersion = "25.05";
	modules = [
	  ./home/home.nix
	];
      };
#  modules = [
#    ./home/liyan/home.nix         
#  ];
#  extraSpecialArgs = { inherit dotfiles; }; 
#      };
    };
}
