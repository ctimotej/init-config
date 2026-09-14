# Core interactive shell and everyday CLI utilities.
{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  programs.tmux.enable = true;

  # neovim stays installed but no longer owns $EDITOR -- plain vim
  # (programs.vim below) is the default editor now.
  programs.neovim = {
    enable = true;
    defaultEditor = false;
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  # Oh My Zsh on top of the plain zsh enabled above. Theme is explicit
  # rather than left to oh-my-zsh.sh's own internal fallback -- robbyrussell
  # is the classic default (colored git-aware prompt with the arrow) that
  # "a standard omz installation" usually means.
  programs.zsh.ohMyZsh = {
    enable = true;
    theme = "robbyrussell";
    plugins = [ "git" ]; # git is already installed; add more here as wanted
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
