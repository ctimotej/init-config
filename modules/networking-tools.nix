# Network diagnostics and packet tooling.
{ pkgs, ... }:

{
  # Declarative Wireshark setup: installs it non-setuid and grants capture
  # capability via the "wireshark" group instead of running it as root.
  # `programs.wireshark.package` now defaults to the CLI-only
  # `wireshark-cli`, so the full GUI has to be requested explicitly.
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  environment.systemPackages = with pkgs; [
    nmap
    tcpdump
    dnsutils # dig, nslookup, host
    traceroute
    mtr
    ethtool
    iperf3
    socat
    netcat
    minicom
    lsof
    iproute2
    bridge-utils
  ];

  users.users.alexis.extraGroups = [ "wireshark" ];
}
