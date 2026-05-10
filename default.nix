{
  pkgs ? import <nixpkgs> { },
  ...
}:
{
  sdFormatLinux = pkgs.callPackage ./package.nix { };
}
