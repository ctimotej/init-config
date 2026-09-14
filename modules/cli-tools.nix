# Core interactive shell and everyday CLI utilities.
{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  programs.tmux.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  environment.systemPackages = with pkgs; [
    ripgrep
    fd
    fzf
    jq
    yq-go # mikefarah/yq (Go): the yq most people mean today, not the older python "yq"
    tree
    curl
    wget
    unzip
    zip
    rsync
    file
    which
    less
    btop
    fastfetch
  ];
}
