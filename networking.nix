{ ... }:

{
  # Network settings
  networking = {
    # Configure network connections interactively with nmcli or nmtui.
    networkmanager.enable = true;

    dhcpcd.extraConfig = "nohook resolv.conf";

    # Cloudflare DNS
    nameservers = [ "2606:4700:4700::1111" "2606:4700:4700::1001" "1.1.1.1" "1.0.0.1" ];

    nftables.enable = true;
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = [
        "1.1.1.1#cloudflare-dns.com"
        "2606:4700:4700::1111#cloudflare-dns.com"
      ];
      FallbackDNS = [
        "1.0.0.1#cloudflare-dns.com"
        "2606:4700:4700::1001#cloudflare-dns.com"
      ];
      Domains = [ "~." ];
      Cache = true;
      LLMNR = false;
      MulticastDNS = false;
    };
  };
}
