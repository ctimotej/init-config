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

  # Oh My Zsh on top of the plain zsh enabled above.
  programs.zsh.ohMyZsh = {
    enable = true;
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
    vim # plain vim, alongside neovim (which stays $EDITOR via defaultEditor above)
  ];
}
