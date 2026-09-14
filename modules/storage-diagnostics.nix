# Storage/filesystem management and hardware diagnostics/firmware tools.
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    btrfs-progs
    cryptsetup
    smartmontools
    nvme-cli
    parted
    pciutils
    usbutils

    acpica-tools
    dmidecode
    lshw
    inxi
    strace
    ltrace

    # Tied to the active kernel package (boot.kernelPackages) rather than a
    # standalone `pkgs.perf`, so it always matches the running kernel.
    config.boot.kernelPackages.perf
  ];
}
