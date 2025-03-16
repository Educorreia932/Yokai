{ pkgs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "Educorreia932";
    repo = "Website";
    rev = "master";
    sha256 = "sha256-4lXhhFP/egIfMk80ex2eerNxEMs9Of0RAwYBwmsHlos=";
  };
  node-modules = pkgs.mkYarnPackage {
    name = "node-modules";
    src = src;
  };
in
pkgs.stdenv.mkDerivation {
  pname = "educorreia932-dev";
  name = "educorreia932-dev";

  src = src;

  buildInputs = with pkgs; [
    node-modules
    yarn
  ];

  buildPhase = ''
    export HOME=$(mktemp -d)
    export YARN_CACHE_FOLDER=$HOME/.yarn-cache
    touch $HOME/.nuxtrc
    ln -s ${node-modules}/libexec/educorreia932.dev/node_modules node_modules
    echo -e "n" | ${pkgs.yarn}/bin/yarn build
  '';

  installPhase = ''
    mkdir $out
    mv .output $out/
  '';

  meta = with pkgs.lib; {
    description = "My personal website";
    maintainers = [ maintainers.educorreia932 ];
    homepage = "https://educorreia932.dev/";
    platforms = platforms.all;
  };
}
