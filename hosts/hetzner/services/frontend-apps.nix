# Frontend Apps Service Configuration (minimal - hackathon only)
{ config, lib, pkgs, domains, hackathon, ... }:

{
  # Hackathon (Static Vite with env vars)
  services.imphnen-hackathon = {
    enable = true;
    domain = domains.hackathon;
    enableSSL = true;
    package = pkgs.imphnen.mkHackathonWithEnv {
      VITE_API_URL = hackathon.apiUrl;
      VITE_GITHUB_CLIENT_ID = hackathon.githubClientId;
    };
  };
}
