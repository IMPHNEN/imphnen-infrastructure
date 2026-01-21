{
  lib,
  pkgs,
  sshKeys,
  ...
}:
{
  time.timeZone = lib.mkDefault "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  boot.tmp.cleanOnBoot = true;

  users.users.root = {
    shell = pkgs.bash;
    openssh.authorizedKeys.keys = sshKeys;
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  system.stateVersion = "25.05";
}
