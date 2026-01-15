# NixOS Server Configuration for IMPHNEN

NixOS flake configuration for Hetzner VPS Powerd by Ancikri.

## Deployment

### Initial deployment

```bash
nix run github:nix-community/nixos-anywhere -- \
  --flake .#hetzner \
  root@<IP_ADDRESS>
```

### Update deployment

```bash
nixos-rebuild switch --flake .#hetzner --target-host root@<IP_ADDRESS> --build-host localhost
```

## Configuration

Update `config.nix` with your VPS details:

```nix
{
  hetzner = {
    hostname = "imphnen";
    ipAddress = "YOUR_IP_ADDRESS";
    gateway = "172.31.1.1";  # Check Hetzner Cloud Console
  };
}
```

## Secrets (sops-nix)

After first deployment, get the server's age key:

```bash
ssh root@<IP> "nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'"
```

Add it to `.sops.yaml`, then edit secrets:

```bash
sops hosts/hetzner/secrets.yaml
```

## Structure

```
imphnen-infrastructure/
├── flake.nix
├── config.nix
├── .sops.yaml
├── hosts/hetzner/
│   ├── default.nix
│   ├── hardware.nix
│   ├── disk-config.nix
│   ├── sops.nix
│   ├── secrets.yaml
│   └── services/
└── profiles/
    ├── base.nix
    └── server.nix
```
