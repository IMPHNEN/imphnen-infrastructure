{ ... }:
{
  sops = {
    defaultSopsFile = ./secrets.yaml;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    # Define your secrets here
    # secrets = {
    #   "myapp/env" = {
    #     mode = "0400";
    #     owner = "root";
    #   };
    # };
  };
}
