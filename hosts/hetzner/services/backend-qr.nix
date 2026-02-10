# Backend QR Service Configuration
{
  config,
  lib,
  pkgs,
  domains,
  ...
}:

{
  # IMPHNEN Backend QR Service
  services.imphnen-backend-qr = {
    enable = true;
    port = 8080;
    openFirewall = false;

    # Database configuration
    database = {
      createLocally = true;
      name = "imphnen_qr";
      user = "imphnen_qr";
    };

    runMigrations = true;

    # Secrets are managed via sops
    environmentFile = config.sops.secrets."backend-qr-env".path;
  };

  # Sops secret for backend environment variables
  sops.secrets."backend-qr-env" = {
    sopsFile = ../secrets.yaml;
    owner = "root";
    group = "root";
    mode = "0400";
  };

  # Nginx reverse proxy for backend API
  services.nginx.virtualHosts.${domains.apiQr} = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8080";
      extraConfig = ''
        # Proxy settings
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Connection "";

        # Timeouts for file uploads (image processing)
        client_max_body_size 10M;
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
      '';
    };
  };
}
