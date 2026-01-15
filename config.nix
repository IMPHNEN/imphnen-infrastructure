{
  hetzner = {
    hostname = "imphnen";
    # TODO: Update with actual Hetzner VPS IP address
    ipAddress = "0.0.0.0";
    gateway = "172.31.1.1";
  };

  acmeEmail = "maulanasdqn@gmail.com";

  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICdLKnxrQl735W+ANR4dnWTrNEMmrIzv7TioI0teJmMZ ms@computer"
  ];
}
