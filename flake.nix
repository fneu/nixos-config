{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl }: 
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
          ./hosts/P51/default.nix
	];
      };
      WSL = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit system; };
	modules = [
	  ./hosts/WSL/default.nix
	  nixos-wsl.nixosModules.wsl
	];
      };
    };
  };
}
