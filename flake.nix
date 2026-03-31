{
  description = "NixOS configuration for Hetzner VPS (Imphnen)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    clan-core = {
      url = "https://git.clan.lol/clan/clan-core/archive/main.tar.gz";
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
      self,
      nixpkgs,
      clan-core,
      imphnen-frontend,
      imphnen-backend-qr,
      ...
    }:
    let
      config = import ./config.nix;

      clan = clan-core.lib.clan {
        inherit self;
        meta.name = "imphnen";

        specialArgs = {
          inherit (config.hetzner) hostname ipAddress gateway;
          inherit (config) sshKeys acmeEmail domains;
        };

        machines.hetzner = {
          nixpkgs.hostPlatform = "x86_64-linux";

          clan.core.networking.targetHost = "root@${config.hetzner.ipAddress}";

          imports = [
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
      };
    in
    {
      inherit (clan.config) nixosConfigurations clanInternals;
      clan = clan.config;

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;

      devShells =
        let
          forSystem =
            system:
            let
              pkgs = nixpkgs.legacyPackages.${system};
            in
            {
              default = pkgs.mkShell {
                packages = [ clan-core.packages.${system}.clan-cli ];
              };
            };
        in
        {
          x86_64-linux = forSystem "x86_64-linux";
          aarch64-darwin = forSystem "aarch64-darwin";
        };
    };
}
