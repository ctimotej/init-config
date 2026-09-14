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

  # WireGuard: just the tooling (`wg`, `wg-quick`), not a tunnel definition
  # -- a real one needs your server's endpoint/public key and a private key,
  # and none of that belongs in this repo. Two ways to actually connect:
  #  1. Easiest, since NetworkManager is already enabled: drop your
  #     provider's .conf at, say, ~/wg0.conf and run
  #     `nmcli connection import type wireguard file ~/wg0.conf`.
  #  2. Fully declarative: add a `networking.wg-quick.interfaces.wg0`
  #     block with `privateKeyFile = "/etc/wireguard/wg0.key";` pointing at
  #     a key file that lives only on this machine (e.g. via
  #     `age`/`sops-nix`, or just `install -m600`), never inlined here.
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
    wireguard-tools
  ];

  users.users.alexis.extraGroups = [ "wireshark" ];
}
