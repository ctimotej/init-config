# Bluetooth. Nothing was enabling it before -- hardware.bluetooth defaults
# to off even when the adapter is present.
{ ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # GUI/tray manager for pairing and connecting devices; also ships the
  # polkit rules and D-Bus service files bluez needs for non-root use.
  # PipeWire/WirePlumber (already enabled in modules/audio.nix) picks up
  # Bluetooth audio devices automatically once the adapter is on -- no
  # extra config needed there.
  services.blueman.enable = true;
}
