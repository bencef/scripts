{stdenv, ocamlPackages}:

stdenv.mkDerivation {
  name = "bencef-scripts";
  version = "0.1.0";
  src = ./.;

  buildInputs = with ocamlPackages; [dune findlib core shexp];

  buildPahse = "dune build @all";

  installPhase = ''
    mkdir -p $out/bin
    for file in $(find _build/default -name '*.exe')
    do
      newname=$(basename $file)
      newname=''${newname%.*}
      cp $file $out/bin/$newname
    done
    rm $out/bin/{utop,ppx}
  '';

  phases = ["unpackPhase" "buildPhase" "installPhase"];
}
