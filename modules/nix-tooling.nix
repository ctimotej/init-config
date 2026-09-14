# Nix development tooling, flake support, and the narrow unfree-package
# allowance the requested software needs. Terraform (bsl11), the
# 1Password CLI/GUI (proprietary), and VS Code (proprietary MS build) are
# the only unfree packages actually pulled in elsewhere in these modules
# -- confirmed against their real `pname`s/licenses in nixpkgs rather than
# guessed (google-cloud-sdk and azure-cli are both plain free-licensed, so
# they don't need to be listed here).
{ pkgs, lib, ... }:

{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "terraform"
      "1password-cli"
      "1password"
      "vscode"
    ];

  environment.systemPackages = with pkgs; [
    # nixfmt-rfc-style is now just an alias for nixfmt (merged 2025-07-14);
    # use the real name directly.
    nixfmt
    nil
    nix-tree
    nix-output-monitor
  ];
}
