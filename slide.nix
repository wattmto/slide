{ stdenvNoCC
, marp-cli
, name
}:

stdenvNoCC.mkDerivation rec {
  inherit name;
  src = ./slide/${name};

  buildInputs = [ marp-cli ];

  buildPhase = ''
    runHook preBuild
    marp PITCHME.md -o ${name}.html
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/${name}
    cp ${name}.html $out/${name}/
    runHook postInstall
  '';
}
