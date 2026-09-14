# Nix development tooling, plus the narrow unfree-package allowance the
# requested software needs (Terraform is BSL-licensed; 1Password is
# proprietary). Several plausible attribute-name spellings are listed for
# robustness across nixpkgs revisions rather than a blanket allowUnfree.
{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "terraform"
      "1password"
      "1password-cli"
      "1password-gui"
      "google-cloud-sdk"
    ];

  environment.systemPackages = with pkgs; [
    nixfmt-rfc-style
    nil
    nix-tree
    nix-output-monitor
  ];
}
