{ stdenv, fish }:

stdenv.mkDerivation {
  name = "fish-shell-scripts";
  srcs = [ ./h.fish ];

  buildInputs = [ fish ];

  dontUnpack = true;
  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    for src in $srcs; do
      strippedSrc=$(stripHash $src)
      srcWithoutExt=''${strippedSrc%.fish}
      cp $src $out/bin/$srcWithoutExt
      chmod +x $out/bin/$srcWithoutExt
    done
  '';
}
