{ config, pkgs, ... }:

{
  imports =
    [ 
      ../../modules/boot.nix
      ../../modules/base.nix

      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "P51"; # Define your hostname.
  system.stateVersion = "23.11"; # Did you read the comment?
}
