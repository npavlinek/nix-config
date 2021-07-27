{ stdenv, pkgs }:

stdenv.mkDerivation {
  name = "readpdf-script";
  src = ./readpdf;

  nativeBuildInputs = with pkgs; [
    fzf
    zathura
  ];

  dontUnpack = true;
  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    strippedSrc=$(stripHash $src)
    srcWithoutExt=''${strippedSrc%.sh}
    cp $src $out/bin/$srcWithoutExt
    chmod +x $out/bin/$srcWithoutExt
  '';
}
