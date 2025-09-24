{
  lib,
  patchelf,
  makeWrapper,
  stdenv,
  fetchFromGitHub,
  ...
}:

stdenv.mkDerivation {
  name = "hostlists";
  version = "git";

  src = fetchFromGitHub {
    owner = "Snowy-Fluffy";
    repo = "zapret.cfgs";
    rev = "52e1b547c6e9ac96836b09eab89f3e9edb7bb69b";
    hash = "sha256-ObCo3e+5VeUgY5J/NH2Ka7x9FC/a2z4Y/2y00XweN20=";
  };

  nativeBuildInputs = [
    makeWrapper
    patchelf
  ];

  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    cp -r . $out/
  '';

  meta = {
    description = "hostlists from zapret.cfgs";
    homepage = "https://github.com/Snowy-Fluffy/zapret.cfgs";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      kotudemo
      azikx
    ];
  };
}
