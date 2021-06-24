{ stdenv, perl }:

stdenv.mkDerivation {
  name = "start-ssh-agent";
  src = ./script.pl;

  buildInputs = [ perl ];

  dontUnpack = true;
  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/$name
    chmod +x $out/bin/$name
  '';
}
