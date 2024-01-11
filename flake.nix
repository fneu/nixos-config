{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
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
    };

  };
}
