{ stdenv }:

stdenv.mkDerivation {
  name = "shell-scripts";
  srcs = [ ./install-nix-config.sh ];

  dontUnpack = true;
  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    for src in $srcs; do
      strippedSrc=$(stripHash $src)
      srcWithoutExt=''${strippedSrc%.sh}
      cp $src $out/bin/$srcWithoutExt
      chmod +x $out/bin/$srcWithoutExt
    done
  '';
}
