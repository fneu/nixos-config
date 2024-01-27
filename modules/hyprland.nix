{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dunst
    waybar
    libnotify
    swww
    rofi-wayland
    firefox
  ];

  services.xserver.enable = false;                        # let's not try to boot into sddm or another display manager
  services.xserver.desktopManager.plasma5.enable = true;  # installing plasma provides all the bits that dolphin & other needs (thumbnails, other services)
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    plasma-browser-integration
    oxygen
    spectacle
    kwalletmanager
  ];

  programs.hyprland.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  environment.sessionVariables = {
    # Fix missing mouse cursor
    WLR_NO_HARDWARE_CURSORS = "1";

    # Hint Electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
  };

  #Sound with pipewire
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  #Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Media Buttons
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = ["network.target" "sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };
}

