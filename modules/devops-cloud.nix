# Infrastructure/DevOps and cloud provider CLIs.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ansible
    terraform # BSL-licensed; see modules/nix-tooling.nix for the unfree allowance
    kubectl
    kubernetes-helm # provides the `helm` binary
    k9s
    kubectx # kubectx/kubens, the standard kubectl context/namespace switchers

    awscli2
    azure-cli
    google-cloud-sdk
  ];
}
