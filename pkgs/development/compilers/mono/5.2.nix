{ stdenv, callPackage, Foundation, libobjc }:

callPackage ./generic-cmake.nix (rec {
  inherit Foundation libobjc;
  version = "5.2.0.215";
  sha256 = "8f0cebd3f7b03f68b9bd015706da9c713ed968004612f1ef8350993d8fe850ea";
})
