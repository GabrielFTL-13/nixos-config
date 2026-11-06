{
  inputs = {
    # This is pointing to an unstable release.
    # If you prefer a stable release instead, you can change the word unstable to the latest number shown here: https://nixos.org/download
    # i.e. nixos-24.11
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ({
          networking.hostName = "nixos";
        })

        ./audio.nix
        ./configuration.nix
        ./desktop.nix
        ./hardware-configuration.nix
        ./networking.nix
        ./programs.nix
        ./ssh.nix
        ./users.nix
      ];
    };
  };
}

