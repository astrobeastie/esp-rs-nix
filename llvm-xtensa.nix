{ lib
, stdenv
, espressif-llvm-project
, python3
, cmake
, ninja
}:

stdenv.mkDerivation rec {
  name = "llvm-xtensa";
  version = "17.0.1";

  src = espressif-llvm-project;

  buildInputs = [
    python3
    cmake
    ninja
  ];

  sourceRoot = "source/llvm";

  cmakeFlags = [
    "-DLLVM_ENABLE_PROJECTS='clang'"
    "-DLLVM_INSTALL_UTILS=ON"
    "-DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD='Xtensa'"
  ];

  meta = with lib; {
    description = "LLVM xtensa";
    homepage = https://github.com/espressif/llvm-project;
    license = licenses.asl20;
  };
}
