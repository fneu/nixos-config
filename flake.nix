{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager }@inputs: 
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
  in
  {

    nixosConfigurations = {
      P51 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system; };
	modules = [
          ./hosts/P51

  	  home-manager.nixosModules.home-manager
  	  {
  	    home-manager.extraSpecialArgs = inputs;
  	    home-manager.users.fabian = import ./home.nix;
  	  }
	];
      };
      WSL = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system; };
	modules = [
	  ./hosts/WSL

  	  home-manager.nixosModules.home-manager
  	  {
  	    home-manager.extraSpecialArgs = inputs;
  	    home-manager.users.fabian = import ./home.nix;
  	  }

	  nixos-wsl.nixosModules.wsl
	];
      };
    };
  };
}
