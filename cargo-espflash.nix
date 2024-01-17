{ lib
, rustPlatform
, espflash
, pkg-config
, udev
, openssl
, libuv
}:

let
  cargoToml = lib.importTOML "${espflash}/cargo-espflash/Cargo.toml";
in
rustPlatform.buildRustPackage {
  pname = cargoToml.package.name;
  inherit (cargoToml.package) version;

  src = espflash;

  buildAndTestSubdir = "cargo-espflash";

  cargoLock.lockFile = "${espflash}/Cargo.lock";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ udev openssl libuv ];

  preBuild = ''
    export OPENSSL_NO_VENDOR=1
  '';

  meta = with lib; {
    inherit (cargoToml.package) description;
    homepage = cargoToml.package.repository;
    licenses = with licenses; [ gpl2 ];
  };
}
