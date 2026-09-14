# Sway (Wayland compositor) desktop.
#
# No terminal emulator was previously configured anywhere in this repo, so
# `foot` was picked as a sensible Wayland-native default -- swap it out
# freely if you'd rather use something else.
{ pkgs, ... }:

{
  programs.sway.enable = true;

  # Sway/wlroots doesn't read services.xserver.xkb.* (that's an X11-only
  # config path); libxkbcommon does fall back to these env vars for any
  # keyboard with no per-device override, so this keeps the Wayland session
  # on the same DE/nodeadkeys layout declared in configuration.nix.
  environment.sessionVariables = {
    XKB_DEFAULT_LAYOUT = "de";
    XKB_DEFAULT_VARIANT = "nodeadkeys";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };

  # swaylock needs its own PAM service; without this it can be bypassed
  # since PAM falls back to an "always succeeds" default for unknown
  # services on some configurations.
  security.pam.services.swaylock = { };

  # Ships udev rules granting the "video" group write access to the
  # backlight sysfs entries brightnessctl needs.
  services.udev.packages = [ pkgs.brightnessctl ];

  environment.systemPackages = with pkgs; [
    waybar
    wofi
    foot
    mako
    grim
    slurp
    wl-clipboard
    swaylock
    swayidle
    kanshi # per-output profiles are machine/monitor specific: configure in ~/.config/kanshi
    brightnessctl
  ];

  users.users.alexis.extraGroups = [ "video" ];
}
