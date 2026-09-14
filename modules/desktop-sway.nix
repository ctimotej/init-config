# Sway (Wayland compositor) desktop.
#
# No terminal emulator was previously configured anywhere in this repo, so
# `foot` was picked as a sensible Wayland-native default -- swap it out
# freely if you'd rather use something else.
{ pkgs, ... }:

{
  programs.sway.enable = true;

  # Sway/wlroots doesn't read services.xserver.xkb.* (that's an X11-only
  # config path), and the XKB_DEFAULT_* env var fallback below isn't
  # reliably honoured by sway's own keyboard handling in practice -- so set
  # it directly where sway actually looks. The stock config sway ships
  # (nixpkgs patches it to `include /etc/sway/config.d/*`) picks this up
  # automatically as long as ~/.config/sway/config doesn't exist/override
  # it, which is the case here since there's no per-user dotfile management.
  environment.etc."sway/config.d/keyboard.conf".text = ''
    input "type:keyboard" {
        xkb_layout "de"
        xkb_variant "nodeadkeys"
    }
  '';

  # Kept as a secondary fallback for XWayland/other Wayland clients that do
  # consult libxkbcommon's env-var defaults directly.
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
