{ lib, stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation rec {
  pname = "ttc-sarasa-gothic-nerd-fonts";
  version = "0.42.5-0";

  src = fetchzip {
    url = "https://github.com/jonz94/${pname}/releases/download/v${version}/sarasa-nerd-font-ttc.zip";
    hash = "";
  };

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    cp *.ttc $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/jonz94/ttc-sarasa-gothic-nerd-fonts";
    description = " Nerd fonts patched Sarasa Gothic font. (ttc format) ";
    license = licenses."0bsd";
    # maintainers = [  ];
    platforms = platforms.all;
  };
}
