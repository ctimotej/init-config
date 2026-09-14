# Containers and desktop virtualization (Docker, KVM/libvirt/QEMU).
#
# Neither daemon is configured to listen on the network: Docker only exposes
# its local unix socket, and libvirtd's default network is NAT-only, so
# nothing here is reachable off the machine.
{ pkgs, ... }:

{
  virtualisation.docker.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.enable = true; # UEFI firmware for guests
    };
  };
  programs.virt-manager.enable = true;

  environment.systemPackages = [ pkgs.docker-compose ];

  users.users.alexis.extraGroups = [ "docker" "libvirtd" ];
}
