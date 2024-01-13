{ lib, pkgs, nixos-wsl, home-manager, ... }:

{
  imports =
    [ 
      ../../modules/base.nix

      home-manager.nixosModules.home-manager

      nixos-wsl.nixosModules.wsl
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  wsl.enable = true;
  wsl.defaultUser = "fabian";

  networking.hostName = "WSL";
  system.stateVersion = "23.11";

  # Home Manager configuration
  home-manager.extraSpecialArgs = { inherit pkgs; };
  home-manager.users.fabian = import ../../home.nix;
}
