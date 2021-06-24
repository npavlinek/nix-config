{ stdenv, python3 }:

stdenv.mkDerivation {
  name = "python-scripts";
  srcs = [ ./get-uptime.py ];

  buildInputs = [ python3 ];

  dontUnpack = true;
  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    for src in $srcs; do
      strippedSrc=$(stripHash $src)
      srcWithoutExt=''${strippedSrc%.py}
      cp $src $out/bin/$srcWithoutExt
      chmod +x $out/bin/$srcWithoutExt
    done
  '';
}
