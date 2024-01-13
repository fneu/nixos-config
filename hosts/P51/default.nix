{ pkgs, nixos-hardware, home-manager, ... }:

{
  imports =
    [ 
      ../../modules/boot.nix
      ../../modules/base.nix

      home-manager.nixosModules.home-manager

      nixos-hardware.nixosModules.lenovo-thinkpad-p51

      ./hardware-configuration.nix
    ];

  networking.hostName = "P51"; # Define your hostname.
  system.stateVersion = "23.11"; # Did you read the comment?

  # Home Manager configuration
  home-manager.extraSpecialArgs = { inherit pkgs; };
  home-manager.users.fabian = import ../../home.nix;
}
