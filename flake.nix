{
  description = "NixOS configuration for Hetzner VPS (Imphnen)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    imphnen-frontend = {
      url = "github:IMPHNEN/imphnen-frontend-service";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    imphnen-backend-qr = {
      url = "github:IMPHNEN/imphnen-backend-qr";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      disko,
      sops-nix,
      imphnen-frontend,
      imphnen-backend-qr,
      ...
    }:
    let
      config = import ./config.nix;
    in
    {
      nixosConfigurations.hetzner = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit (config.hetzner) hostname ipAddress gateway;
          inherit (config) sshKeys acmeEmail domains;
        };
        modules = [
          disko.nixosModules.disko
          sops-nix.nixosModules.sops

          # Apply overlays
          {
            nixpkgs.overlays = [
              imphnen-frontend.overlays.default
              imphnen-backend-qr.overlays.default
            ];
          }

          # Import frontend modules
          imphnen-frontend.nixosModules.landing
          imphnen-frontend.nixosModules.gacha
          imphnen-frontend.nixosModules.backoffice
          imphnen-frontend.nixosModules.dimentorin
          imphnen-frontend.nixosModules.hackathon
          imphnen-frontend.nixosModules.infra
          imphnen-frontend.nixosModules.qrcampaign

          # Import backend modules
          imphnen-backend-qr.nixosModules.backend-qr

          ./hosts/hetzner
        ];
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
    };
}
