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
      proxyWebsockets = true;
      extraConfig = ''
        # CORS headers
        add_header 'Access-Control-Allow-Origin' '*' always;
        add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS' always;
        add_header 'Access-Control-Allow-Headers' 'Authorization, Content-Type' always;

        # Handle preflight requests
        if ($request_method = 'OPTIONS') {
          add_header 'Access-Control-Allow-Origin' '*';
          add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS';
          add_header 'Access-Control-Allow-Headers' 'Authorization, Content-Type';
          add_header 'Access-Control-Max-Age' 1728000;
          add_header 'Content-Type' 'text/plain charset=UTF-8';
          add_header 'Content-Length' 0;
          return 204;
        }

        # Proxy settings
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Timeouts for file uploads (image processing)
        client_max_body_size 10M;
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
      '';
    };
  };
}
