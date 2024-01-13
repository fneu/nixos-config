{ config, pkgs, nixos-hardware, home-manager, ... }:

{
  imports =
    [ 
      ../../modules/boot.nix
      ../../modules/base.nix

      nixos-hardware.nixosModules.lenovo-thinkpad-p51

      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "P51"; # Define your hostname.
  system.stateVersion = "23.11"; # Did you read the comment?
}
