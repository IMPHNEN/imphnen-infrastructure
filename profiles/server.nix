{
  lib,
  pkgs,
  acmeEmail,
  ...
}:
{
  imports = [
    ./base.nix
  ];

  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://msdqn.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "msdqn.cachix.org-1:I5z8egjNf2iKYLwLGF2REfpELlFoUdaSLsh7dQk1a+o="
    ];
  };

  time.timeZone = lib.mkForce "UTC";

  networking = {
    useDHCP = lib.mkDefault true;
    networkmanager.enable = false;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 ];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = acmeEmail;
  };

  # Minimal packages only
  environment.systemPackages = with pkgs; [
    htop
  ];
}
