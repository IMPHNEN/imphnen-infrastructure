# Frontend Apps Service Configuration
{ config, lib, pkgs, domains, ... }:

{
  # Landing (Next.js) - systemd service
  services.imphnen-landing = {
    enable = true;
    port = 3000;
    hostname = "127.0.0.1";
    openFirewall = false;
  };

  # Nginx reverse proxy for landing
  services.nginx.virtualHosts.${domains.landing} = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:3000";
      proxyWebsockets = true;
    };
  };

  # Gacha (Static Vite app)
  services.imphnen-gacha = {
    enable = true;
    domain = domains.gacha;
    enableSSL = true;
  };

  # Backoffice (Static Vite app)
  services.imphnen-backoffice = {
    enable = true;
    domain = domains.backoffice;
    enableSSL = true;
  };

  # Dimentorin (Static Vite app)
  services.imphnen-dimentorin = {
    enable = true;
    domain = domains.dimentorin;
    enableSSL = true;
  };

  # Hackathon (Static Vite app)
  services.imphnen-hackathon = {
    enable = true;
    domain = domains.hackathon;
    enableSSL = true;
  };
}
