{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Adicione pacotes do sistema aqui.
    gnumake
    gcc
    python3
  ];

  # Firefox
  programs.firefox.enable = true;

  # Git
  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  # Java
  programs.java = {
    enable = true;
    binfmt = true;
  };

  # Podman
  virtualisation = {
    containers.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
  };

  # Neovim
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  # ZSH
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      la = "ls -lAh";
      edit = "sudo -e";
      update = "cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch --flake .#nixos";
      reset-config = "cd /etc && sudo rm -rf nixos && sudo git clone https://github.com/chrisrnj/nixos-uvv nixos && sudo rm -rf nixos/.git && sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    };

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "podman"
        "python"
        "safe-paste"
        "ssh"
        "systemd"
        "z"
      ];
      theme = "intheloop";
    };
  };
}
