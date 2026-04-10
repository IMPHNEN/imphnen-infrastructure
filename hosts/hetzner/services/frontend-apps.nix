# Frontend Apps Service Configuration
{ config, lib, pkgs, domains, ... }:

{
  # Landing (Astro static site)
  services.imphnen-landing = {
    enable = true;
    domain = domains.landing;
    enableSSL = true;
  };

  # www subdomain redirects to main domain
  services.nginx.virtualHosts.${domains.www} = {
    forceSSL = true;
    enableACME = true;
    globalRedirect = domains.landing;
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

  # Infra (Static Vite app - infrastructure documentation)
  services.imphnen-infra = {
    enable = true;
    domain = domains.infra;
    enableSSL = true;
  };

  # QR Campaign (Static Vite app)
  services.imphnen-qrcampaign = {
    enable = true;
    domain = domains.qr;
    enableSSL = true;
  };
}
