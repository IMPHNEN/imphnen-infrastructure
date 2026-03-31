{
  hostname,
  ipAddress,
  gateway,
  domains,
  hackathon,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./disk-config.nix
    ../../profiles/server.nix
    ./sops.nix
    ./services/frontend-apps.nix
    ./services/backend-qr.nix
  ];

  # Use systemd-networkd (required by clan-core)
  networking = {
    hostName = hostname;
    useDHCP = false;
    useNetworkd = true;
    nameservers = [
      "185.12.64.1"
      "185.12.64.2"
      "1.1.1.1"
    ];
  };

  systemd.network.networks."40-enp1s0" = {
    matchConfig.Name = "enp1s0";
    address = [ "${ipAddress}/32" ];
    gateway = [ gateway ];
    dns = [
      "185.12.64.1"
      "185.12.64.2"
      "1.1.1.1"
    ];
    networkConfig.DHCP = "no";
  };
}
