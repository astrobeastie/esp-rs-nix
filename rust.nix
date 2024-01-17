{ callPackage
, fetchFromGitHub
}:

rec {
  version = "1.75.0";

  src = callPackage ./rust-src.nix { };

  fetchCargoTarball = callPackage ./fetch-cargo-tarball { };
  cargoDeps = fetchCargoTarball {
    inherit src;
    sha256 = "sha256-0CxiIXS+UEVsVi7ps+uwEduyq8n+sQ4PurqB1/B4jlQ=";
  };
}
