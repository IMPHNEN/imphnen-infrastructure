# NixOS Server Configuration for IMPHNEN

NixOS flake configuration for Hetzner VPS.

## Deployed Apps

| App | Domain | Type |
|-----|--------|------|
| Landing | imphnen.dev | Next.js |
| Gacha | gacha.imphnen.dev | Vite |
| Backoffice | backoffice.imphnen.dev | Vite |
| Dimentorin | dimentorin.imphnen.dev | Vite |
| Hackathon | hackathon.imphnen.dev | Vite |
| Infra | infra.imphnen.dev | Vite |

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

### Remote build (recommended for cross-platform)

```bash
nixos-rebuild switch --flake .#hetzner --target-host root@<IP_ADDRESS> --build-host root@<IP_ADDRESS>
```

## Configuration

Update `config.nix` with your VPS details:

```nix
{
  hetzner = {
    hostname = "imphnen";
    ipAddress = "YOUR_IP_ADDRESS";
    gateway = "172.31.1.1";
  };

  domains = {
    landing = "imphnen.dev";
    gacha = "gacha.imphnen.dev";
    backoffice = "backoffice.imphnen.dev";
    dimentorin = "dimentorin.imphnen.dev";
    hackathon = "hackathon.imphnen.dev";
    infra = "infra.imphnen.dev";
  };
}
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
│       └── frontend-apps.nix
└── profiles/
    ├── base.nix
    └── server.nix
```
