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
    hashedPassword = "$6$0WWQ.kChMXAsFEMO$jlujK5zsa.4xp1jKSowNae/b3/WBEXqXLOuGGT04am/kMHLwW4KyoImoriMYV3pv2LplyWsHwY1uXJEJwPDzZ1";
    openssh.authorizedKeys.keys = sshKeys;
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    substituters = [
      "https://cache.nixos.org"
      "https://msdqn.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "msdqn.cachix.org-1:I5z8egjNf2iKYLwLGF2REfpELlFoUdaSLsh7dQk1a+o="
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 3d";
  };

  system.stateVersion = "25.05";
}
