# 1Password integration, GnuPG, and general crypto/secrets tooling.
#
# 1Password's own SSH agent is used instead of gpg-agent's SSH support or a
# plain ssh-agent, so only one agent ever owns SSH_AUTH_SOCK.
{ pkgs, ... }:

{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "alexis" ];
  };

  environment.sessionVariables.SSH_AUTH_SOCK = "$HOME/.1password/agent.sock";

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false; # 1Password provides the SSH agent instead
  };

  environment.systemPackages = with pkgs; [
    openssl
    age
  ];
}
