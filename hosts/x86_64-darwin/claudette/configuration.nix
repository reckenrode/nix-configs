{ ... }:

{
  imports = [
    ./cups
    ./keybase.nix
    ./secretive.nix
  ];

  networking.hostName = "claudette";
}
