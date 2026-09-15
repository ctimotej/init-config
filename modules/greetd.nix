# Autologin straight into Sway via greetd.
#
# Security note: this skips the graphical login prompt entirely on boot --
# after LUKS unlocks the disk, anyone at the keyboard lands directly in
# alexis's desktop session with no further password gate. That's a
# reasonable trade-off for a single-user laptop already protected by
# full-disk encryption, but it is a real reduction in defense-in-depth
# versus requiring a session password too. If you ever want the login
# prompt back, drop the `initial_session` block below (default_session
# alone, via tuigreet, already covers a normal login flow).
{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    useTextGreeter = true; # for the tuigreet fallback below
    settings = {
      # Runs once, unconditionally, without any prompt.
      initial_session = {
        command = "${config.programs.sway.package}/bin/sway";
        user = "alexis";
      };
      # Falls back to this (a normal login prompt) if the session above
      # ever exits, e.g. after logging out.
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
      };
    };
  };
}
