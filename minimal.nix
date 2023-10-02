{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  /*
  # bios
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };
  */

  /*
  # uefi
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      efiSupport = true;
      device = "nodev";
    };
  };
  */

  users.users = {
    kmies = {
      autoSubUidGidRange = true;
      extraGroups = [
        "wheel"
      ];
      home = "/home/kmies";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJGb5cPrpHA5mLxknm0WInP6NuZylMCE6Z9LT+IRT7J4 kmies@zeus"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINPHYRrfnqRtSZnWOL0yv/tHTCufnSZaS372FoiZOwEm kmies@droid"
      ];
      uid = 1000;
    };

    root = {
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJGb5cPrpHA5mLxknm0WInP6NuZylMCE6Z9LT+IRT7J4 kmies@zeus"];
    };
  };

  services.openssh.enable = true;

  system.stateVersion = "23.05";
}
