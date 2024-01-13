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

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, nixos-hardware }@inputs: 
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
        specialArgs = {inherit system; inherit pkgs; inherit nixos-hardware; inherit home-manager; };
	modules = [
          ./hosts/P51
	];
      };
      WSL = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system; inherit pkgs; inherit nixos-wsl; inherit home-manager; };
	modules = [
	  ./hosts/WSL
	];
      };
    };
  };
}
