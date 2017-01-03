    # Edit this configuration file to define what should be installed on
    # your system.  Help is available in the configuration.nix(5) man page
    # and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    system.stateVersion = "16.09";
    time.timeZone = "America/Chicago";

    # Use the systemd-boot EFI boot loader.
    boot.loader =
    {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        grub.device = /dev/sdc2;
    };

    networking =
    {
        networkmanager.enable = true;
    };

    # Set your time zone.
    environment.systemPackages = with pkgs; [
        wget
        firefox
        chromium
        git
        i3status
        dmenu
        ruby
        virtualbox
        pash
        mono
        mariadb
        vlc
        xz
        gzip
        nss
        openjdk
        python
        kate
    ];
    services =
    {
        locate.enable = true;
        samba.enable = true;
        #openssh.enable = true;
        printing =
        {
            enable = true;
            drivers = [ pkgs.gutenprint ];
        };
        xserver =
        {
            enable = true;
            displayManager.lightdm.enable = true;
            windowManager.i3.enable = true;
            #desktopManager.kde5.enable = true;
            layout = "us";
            xkbOptions = "compose:caps";
        };
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.extraUsers.johann = {
        isNormalUser = true;
        extraGroups=["wheel"];
    };
}
