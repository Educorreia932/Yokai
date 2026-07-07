{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "educorreia932-dev";
  version = "master";

  src = pkgs.fetchFromGitHub {
    owner = "Educorreia932";
    repo = "Website";
    rev = "master";
    sha256 = "sha256-4lXhhFP/egIfMk80ex2eerNxEMs9Of0RAwYBwmsHlos=";
  };

  buildInputs = [
    pkgs.nodejs
    pkgs.yarn
  ];

  # Use the built-in yarn hooks
  yarnLock = "yarn.lock";
  packageJSON = "package.json";

  installPhase = ''
    mkdir -p $out
    mv .output $out/
  '';

  meta = with pkgs.lib; {
    description = "My personal website";
    maintainers = [ maintainers.educorreia932 ];
    homepage = "https://educorreia932.dev/";
    platforms = platforms.all;
  };
}
