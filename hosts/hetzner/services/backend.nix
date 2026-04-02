{
  config,
  lib,
  pkgs,
  domains,
  ...
}:
{
  services.imphnen-backend = {
    enable = true;
    port = 8081;
    openFirewall = false;
    environmentFile = config.sops.secrets."backend-env".path;
  };

  sops.secrets."backend-env" = {
    sopsFile = ../secrets.yaml;
    owner = "root";
    group = "root";
    mode = "0400";
  };

  services.nginx.virtualHosts.${domains.api} = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8081";
      recommendedProxySettings = false;
      extraConfig = ''
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Connection "";

        client_max_body_size 10M;
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
      '';
    };
  };
}
