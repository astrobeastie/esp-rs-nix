{ lib
, callPackage
, llvm-xtensa
, rustc-unwrapped
}:

let
  rust = callPackage ./rust.nix { };
in
rustc-unwrapped.overrideAttrs (oA: rec {
  pname = "rustc-xtensa";
  inherit (rust) version src cargoDeps;

  llvmSharedForBuild = llvm-xtensa;
  llvmSharedForHost = llvm-xtensa;
  llvmSharedForTarget = llvm-xtensa;
  llvm = llvm-xtensa;

  configureFlags =
    (lib.lists.remove "--enable-llvm-link-shared"
      (lib.lists.remove "--release-channel=stable" (oA.configureFlags or []) )) ++ 
    [
      "--llvm-root=${llvm-xtensa}"
      "--experimental-targets=Xtensa"
      "--release-channel=nightly"
    ];

  postConfigure = ''
    unpackFile "$cargoDeps"
    mv $(stripHash $cargoDeps) vendor
    # export VERBOSE=1
  '';

    postInstall = ''
    mkdir -p $out/lib/rustlib/src
    ln -s $src $out/lib/rustlib/src/rust
    mkdir $out/vendor
    ln -s $src/library/rustc-std-workspace-alloc $out/vendor/rustc-std-workspace-alloc
    ln -s $src/library/rustc-std-workspace-core $out/vendor/rustc-std-workspace-core
    ln -s $src/library/rustc-std-workspace-std $out/vendor/rustc-std-workspace-std
  '';
})
