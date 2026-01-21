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

  # Domain mappings for frontend apps
  domains = {
    landing = "imphnen.dev";
    gacha = "gacha.imphnen.dev";
    backoffice = "backoffice.imphnen.dev";
    dimentorin = "dimentorin.imphnen.dev";
    hackathon = "hackathon.imphnen.dev";
  };

  # Hackathon app environment variables
  hackathon = {
    apiUrl = "phc_sZ366i7wdUq8pV7gf676BUefqP2zY1pXWldKtHDQMMm";
    githubClientId = "Ov23li2IkCehE18qZO4R";
  };
}
