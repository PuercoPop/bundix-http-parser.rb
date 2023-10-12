{ system ? builtins.currentSystem, nixpkgs ? fetchTarball {
  url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.05.tar.gz";
  sha256 = "10wn0l08j9lgqcw8177nh2ljrnxdrpri7bp0g7nvrsn9rkawvlbf";
}, pkgs ? import nixpkgs {
  overlays = [ ];
  config = { };
  inherit system;
} }:
let
  ruby = pkgs.ruby_3_2;
  gems = pkgs.bundlerEnv {
    inherit ruby;
    name = "jekyll-gems";
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in
{
  shell = pkgs.stdenv.mkDerivation {
    name = "jekyll_env";
    src = ./.;
    buildInputs = [
      gems
      gems.wrappedRuby
    ];
  };
}
