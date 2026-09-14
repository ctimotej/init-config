# Git and GitHub tooling.
#
# Credential storage: `gh auth login` (or `gh auth setup-git`) configures gh
# itself as git's credential helper, which covers "appropriate Git
# credential support" without adding a second credential manager.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    gh
    git-lfs
    openssh
  ];
}
