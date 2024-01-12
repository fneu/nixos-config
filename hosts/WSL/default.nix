{ config, lib, pkgs, nixos-wsl, ... }:

{
  imports =
    [ 
      ../../modules/base.nix
    ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  wsl.enable = true;
  wsl.defaultUser = "fabian";

  networking.hostName = "WSL";
  system.stateVersion = "23.11";
}
