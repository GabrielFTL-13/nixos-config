{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tux = {
    isNormalUser = true;
    description = "Tux";
    extraGroups = [
      "wheel"
    ];
    packages = with pkgs; [
      # Adicione pacotes específicos para o usuário aqui.
      sl
    ];
    shell = config.programs.zsh.package;
  };
}
