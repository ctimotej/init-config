# General desktop applications (not tied to the Sway compositor itself).
{ pkgs, ... }:

{
  # --- Flatpak, for Discord ---
  #
  # The NixOS flatpak module only manages the flatpak service/daemon
  # declaratively -- it has no option to declare which remotes or apps are
  # installed, since that state (/var/lib/flatpak) lives outside the Nix
  # store and isn't something Nix can build or garbage-collect. This oneshot
  # gets as close to declarative as flatpak allows: on every boot it
  # (re-)adds the Flathub remote and (re-)installs Discord, both of which
  # are no-ops once already done. Requires xdg.portal.enable, which
  # modules/desktop-sway.nix already turns on.
  services.flatpak.enable = true;

  systemd.services.flatpak-provision-discord = {
    description = "Ensure the Flathub remote and the Discord flatpak are installed";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${pkgs.flatpak}/bin/flatpak remote-add --system --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      ${pkgs.flatpak}/bin/flatpak install --system --noninteractive -y flathub com.discordapp.Discord
    '';
  };

  # --- LibreWolf ---
  environment.systemPackages = [
    pkgs.librewolf
  ];

  # --- KDE Connect ---
  # Opens TCP+UDP 1714-1764 for phone/desktop discovery and pairing over the
  # local network; that's inherent to how KDE Connect works, not incidental
  # exposure.
  programs.kdeconnect.enable = true;
}
