{
  hetzner = {
    hostname = "imphnen";
    ipAddress = "167.235.70.37";
    gateway = "172.31.1.1";
  };

  acmeEmail = "maulanasdqn@gmail.com";

  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICdLKnxrQl735W+ANR4dnWTrNEMmrIzv7TioI0teJmMZ ms@computer"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWtjKE/K1glzg1pP/qg6Z6fDl/9mnpbPYfYeFsx2u5fVAQsmWgNDT2j+KBAOIX/r2LWO6aW/bvGXUdV38UhzYMO7NqRNSl3EO7HnbrcThPwO24gmqc9DQE9DQaLt+wsZIiBvxrwl8TA8CZJ0NZg6k9yZm7GrWqe/10Tz0P5JVQqktHzcH8SCV6bZzUnbwWU3Xfh+QbCBRHSwDjhqCy4TiZ0j48cAau5p1xGI+t0977tGI4Jy90tUJt7ntDpY8Awjkz2KvQoEOXQBfpYS2ioW7BGX1fyY00nXJcHUqLkP2YcirpA9RmNbciKo6CClXkmidbciVPYOhDZa5msgF6iuP0n91HBEJZzg5EZQ2f4catAi+Hi2R5nFpSiAsTmLzxjCdPPDf30eH61DmZX+r5Ro+CqTGjp/HeR4AyBFuH/YgZ0ySYHdFoMdDWnTpXZF4UIlF+6iBZ/DcsQtOnfUl6Q5Mfk4qqw9AFsTuwV/u3FzhnVslRK95uRu9g1oORL7i/r6E= ochi@darmaputra-ochi"
  ];

  # Domain mappings
  domains = {
    # Frontend apps
    landing = "imphnen.dev";
    www = "www.imphnen.dev";
    gacha = "gacha.imphnen.dev";
    backoffice = "backoffice.imphnen.dev";
    dimentorin = "dimentorin.imphnen.dev";
    hackathon = "hackathon.imphnen.dev";
    infra = "infra.imphnen.dev";
    qr = "qr.imphnen.dev";

    # Backend APIs
    apiQr = "api-qr.imphnen.dev";
  };
}
