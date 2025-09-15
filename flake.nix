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

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system}; 
#      dotfiles = /home/liyan/.dotfiles;
    in
    {
      nixosConfigurations.liyan = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
	  ./hosts/default
          # ./hosts/default/hardware.nix
          # ./hosts/default/default.nix
          # ./modules/boot/grub.nix
          # ./modules/system/networking.nix
          # ./modules/system/nix-settings.nix
          # ./modules/system/audio.nix
          # ./modules/system/fonts.nix
          # ./modules/system/zsh.nix
          # ./modules/desktop/apps.nix
          # ./modules/desktop/hyprland.nix
          # ./modules/boot/sddm.nix
          # ./modules/boot/opt.nix
          # ./modules/system/bt.nix
	  # home-manager.nixosModules.home-manager
	  # {
	  #   home-manager.useGlobalPkgs = true;
	  #   home-manager.useUserPackages = true;
	  #   home-manager.users.liyan = import ./home/liyan/home.nix;
	  # }
        ];
      };

  #    homeConfigurations.liyan = home-manager.lib.homeManagerConfiguration {
 #       inherit pkgs;
 #       username = "liyan";
 #       homeDirectory = "/home/liyan";
#  modules = [
#    ./home/liyan/home.nix          # ✅ path langsung
#  ];
#  extraSpecialArgs = { inherit dotfiles; };  # passing dotfiles
#      };
    };
}
