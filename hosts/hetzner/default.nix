{
  hostname,
  ipAddress,
  gateway,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./disk-config.nix
    ../../profiles/server.nix
    ./sops.nix
    # Add your services here
    # ./services/your-service.nix
  ];

  # Hetzner Cloud network interface: enp1s0, eth0, or ens3
  networking = {
    hostName = hostname;
    useDHCP = false;
    interfaces.enp1s0.ipv4.addresses = [
      {
        address = ipAddress;
        prefixLength = 32;
      }
    ];
    defaultGateway = {
      address = gateway;
      interface = "enp1s0";
    };
    nameservers = [
      "185.12.64.1"
      "185.12.64.2"
      "1.1.1.1"
    ];
  };
}
