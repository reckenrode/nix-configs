_: prev:

let
  derivation = { lib, fetchurl, stdenv, undmg, steam-icon ? null }:
    stdenv.mkDerivation rec {
      pname = "steam";
      version = "2022.03.07";

      src = fetchurl {
        url = "https://web.archive.org/web/20220307001519/https://cdn.cloudflare.steamstatic.com/client/installer/steam.dmg";
        hash = "sha256-86WB93ckhFALP1onHDH4kba0sayBglXf2cOtXb4QSl4";
      };

      buildInputs = [ undmg ];

      unpackPhase = ''
        undmg $src
      '';

      installPhase = ''
        mkdir -p $out/Applications
        cp -r *.app $out/Applications
      '' + lib.optionalString (steam-icon != null) ''
        cp ${steam-icon} $out/Applications/Steam.app/Contents/Resources/Steam.icns
      '';

      meta = {
        description = ''
          Steam is the ultimate destination for playing, discussing, and creating games.
        '';
        homepage = "https://steampowered.com";
        license = lib.licenses.unfree;
        platforms = [ "x86_64-darwin" ];
      };
    };
in
prev.callPackage derivation { }
