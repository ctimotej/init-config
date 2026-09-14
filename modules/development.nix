# Compilers, build tools and language toolchains.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    cmake
    pkg-config

    # rustup manages rustc/cargo/components/editions the way Rust's own docs
    # expect; that's a better fit for "the Rust toolchain" than pinning a
    # single nixpkgs rustc/cargo pair.
    rustup

    python3
    python3Packages.pip

    nodejs

    go

    shellcheck
    pre-commit
  ];
}
