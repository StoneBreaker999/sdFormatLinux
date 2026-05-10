{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "sdFormatLinux";
  version = "0.2.0";

  src = ./.;

  # In the makefile the `TARGET` variable is the directory's name
  # and that is conflicting with the existing `source` directory.
  # I would fix the makefile myself if I knew make...
  makeFlags = [ "TARGET=${finalAttrs.pname}" ];

  # The original makefile doesn't have an install command!
  installPhase = ''
    runHook preInstall;
    install -Dm 755 ${finalAttrs.pname} -t $out/bin/
    runHook postInstall;
  '';
})
