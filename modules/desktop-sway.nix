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

  # xdg-desktop-portal-wlr only implements Screenshot/ScreenCast -- it has
  # no FileChooser (or most other) portal backend. Without one, any "Save
  # As"/download-location dialog that goes through the portal system (e.g.
  # Discord, being a sandboxed Flatpak) has nothing to answer it and just
  # fails/hangs. xdg-desktop-portal-gtk fills that gap; nixpkgs' own
  # assertion for xdg.portal.extraPortals recommends exactly this pairing.
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Make sure ~/Downloads actually exists -- there's no display manager or
  # xdg-user-dirs autostart wired up in this minimal Sway setup to create it
  # on first login, and both browsers and portal-mediated downloads assume
  # it's there.
  systemd.tmpfiles.rules = [
    "d /home/alexis/Downloads 0755 alexis users -"
  ];

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
