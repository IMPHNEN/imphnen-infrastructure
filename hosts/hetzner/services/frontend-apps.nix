# Frontend Apps Service Configuration
{ config, lib, pkgs, domains, hackathon, ... }:

{
  # Landing (Next.js) - systemd service, proxied by nginx
  services.imphnen-landing = {
    enable = true;
    port = 3000;
    hostname = "127.0.0.1";
    openFirewall = false;
  };

  # Gacha (Static Vite)
  services.imphnen-gacha = {
    enable = true;
    domain = domains.gacha;
    enableSSL = true;
  };

  # Backoffice (Static Vite)
  services.imphnen-backoffice = {
    enable = true;
    domain = domains.backoffice;
    enableSSL = true;
  };

  # Dimentorin (Static Vite)
  services.imphnen-dimentorin = {
    enable = true;
    domain = domains.dimentorin;
    enableSSL = true;
  };

  # Hackathon (Static Vite with API and GitHub OAuth)
  services.imphnen-hackathon = {
    enable = true;
    domain = domains.hackathon;
    enableSSL = true;
    package = pkgs.imphnen.mkHackathonWithEnv {
      VITE_API_URL = hackathon.apiUrl;
      VITE_GITHUB_CLIENT_ID = hackathon.githubClientId;
    };
  };

  # Nginx reverse proxy for landing (main domain)
  services.nginx.virtualHosts.${domains.landing} = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:3000";
      proxyWebsockets = true;
      extraConfig = ''
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
      '';
    };
  };
}
