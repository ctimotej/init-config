# nix-ld: lets dynamically-linked binaries that weren't built for NixOS
# (no /lib or /usr/lib to find shared libraries in, unlike a normal distro)
# run anyway, by giving them a compatible dynamic linker plus a curated
# library path. This is the NixOS equivalent of `apt install libx11-6
# libxcursor1 libxrandr2 libxi6 libxext6 libxkbcommon0` -- those exact
# Debian package names don't exist here, but this gets the same X11/Wayland
# input libraries onto a path such a binary can actually find.
{ pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libx11
      libxcursor
      libxrandr
      libxi
      libxext
      libxkbcommon
    ];
  };
}
