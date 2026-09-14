# ThinkPad power management and firmware/sensor tooling.
#
# TLP, not power-profiles-daemon: TLP has ThinkPad-specific handling
# (battery charge thresholds, radio/USB autosuspend policy) that suits this
# hardware better than PPD's simpler profile model. Running both fights over
# the same kernel knobs, so PPD is explicitly disabled.
{ pkgs, ... }:

{
  services.tlp.enable = true;
  services.power-profiles-daemon.enable = false;

  services.fwupd.enable = true;

  environment.systemPackages = with pkgs; [
    powertop
    lm_sensors
  ];
}
