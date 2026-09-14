# Windows / Active Directory / enterprise-network client tooling.
#
# This installs *client* tooling only. `samba` here provides smbclient,
# rpcclient, nmblookup and testparm -- the SMB *server* (services.samba) is
# intentionally not enabled, since no file sharing was requested and running
# an SMB daemon would expose a service unnecessarily.
#
# services.sssd is intentionally not pre-enabled: with no domain configured
# it would just be a permanently-failing unit, and no domain/realm details
# belong in this repo anyway. `realm join <domain>` (from realmd, enabled
# below) writes sssd's domain config and starts the service itself once you
# actually join a domain.
{ pkgs, ... }:

{
  services.realmd.enable = true;

  environment.systemPackages = with pkgs; [
    samba # smbclient, rpcclient, nmblookup, testparm
    cifs-utils # mount.cifs
    krb5 # kinit, klist, kdestroy, ...
    openldap # ldapsearch, ldapadd, ...
    adcli
    powershell
  ];
}
