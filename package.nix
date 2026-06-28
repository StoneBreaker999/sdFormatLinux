{
  pkgs,
  lib,
  stdenv,
  fetchFromGitHub,

  util-linux,
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

  postPatch = ''
    substituteInPlace source/blockdev.cpp \
      --replace-fail '/usr/bin/lsblk' '${util-linux}/bin/lsblk' \
      --replace-fail 'char cmd[64]' 'char cmd[123]' \
      --replace-fail 'strncpy(&cmd[43], path, sizeof(cmd) - 43)' 'strncpy(&cmd[102], path, sizeof(cmd) - 102)' \
  '';

  # The original makefile doesn't have an install command!
  installPhase = ''
    runHook preInstall;
    install -Dm 755 ${finalAttrs.pname} -t $out/bin/
    runHook postInstall;
  '';
})
