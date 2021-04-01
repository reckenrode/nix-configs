{ lib, fetchurl, stdenv, undmg, system }:

let
  suffixes = { aarch64-darwin = "-aarch64"; x86_64-darwin = ""; };
  suffix = suffixes.${system};
in stdenv.mkDerivation rec {
  pname = "pycharm-professional";
  version = "2020.3.5";

  src = fetchurl {
    url = "https://download.jetbrains.com/python/${pname}-${version}${suffix}.dmg";
    sha256 = "EoUBz5aYg4Xk3SyF+1ZMruGv7BiVjW7L6Bngvcdm8mM=";
  };

  nativeBuildInputs = [ undmg ];

  unpackPhase = ''
    undmg $src
  '';

  installPhase = ''
    mkdir -p $out/Applications
    cp -r *.app $out/Applications
  '';

  meta = with lib; {
    description = ''
      Python IDE with complete set of tools for productive
      development with Python programming language. In addition, the
      IDE provides high-class capabilities for professional Web
      development with Django framework and Google App Engine. It
      has powerful coding assistance, navigation, a lot of
      refactoring features, tight integration with various Version
      Control Systems, Unit testing, powerful all-singing
      all-dancing Debugger and entire customization. PyCharm is
      developer driven IDE. It was developed with the aim of
      providing you almost everything you need for your comfortable
      and productive development!
    '';
    homepage = "https://www.jetbrains.com/pycharm/";
    changelog = "https://www.jetbrains.com/pycharm/whatsnew/";
    license = licenses.unfree;
    platforms = [ "x86_64-darwin" "aarch64-darwin" ];
  };
}