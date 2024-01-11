# NixOS Configuration

## Install

- Install NixOS
- Edit `/etc/nixos/configuration.nix`:
  - Install git:
    ```nix
    environment.systemPackages = with pkgs; [
      git
    ];
    ```
  - Install neovim:
    ```nix
    programs.neovim.enable = true;
    programs.neovim.defaultEditor = true;
    ```
  - Enable flakes:
    ```nix
    nix.settings.experimental-features = ["nix-command" "flakes"];
    ```
- Rebuild system with `sudo nixos-rebuild switch`
- Create new ssh-key with `ssh-keygen -t ed25519 -C "some@email.com"` and add public key to Github.
- Clone this repo
- On new machines, create a new configuration:
  - Add directory in `/hosts`
  - Copy and adjust `default.nix` from another host
  - Copy `hardware-configuration.nix` from `/etc/hardware-configuration.nix` to this directory
  - Add a named entry to `nixosConfigurations` in `flake.nix`
- Build a NixOS Configuration:
  ```bash
  sudo nixos-rebuild switch --flake .#<NEWNAME>
  ```
