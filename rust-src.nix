{ fetchFromGitHub }:

fetchFromGitHub {
  owner = "esp-rs";
  repo = "rust";
  # https://github.com/esp-rs/rust/tree/esp-1.58.0.0
  rev = "8edb9b87e75769a7656750176d5cad285229a789";
  fetchSubmodules = true;
  sha256 = "sha256-jvWrb13X8E3ZlTZsHpyU5imQhEKC0GexWo9eaoHiGFc=";
}
