{ config, pkgs, ... }:

{
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "ro_nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fabian = {
    isNormalUser = true;
    description = "Fabian Neuschmidt";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    home-manager
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  ##### Vimjoyer Tutorial Things #####

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
