{
  description = "Properly format SD cards under Linux.";
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-26.05";
  };
  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux"; # TODO: allow other systems
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      defaultPackage.${system} = pkgs.callPackage ./package.nix { };

    };
}
