{
  lib,
  pkgs,
  python3Packages,
}:

python3Packages.buildPythonPackage rec {
  pname = "lyricsgenius";
  version = "3.0.1";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "sha256-g671X/yguOppZRxLFEaT0cASaHp9pX+I0JWzM/LhiSg=";
  };

  propagatedBuildInputs = with python3Packages; [
    requests
  ];

  doCheck = false;

  meta = with lib; {
    description = "Python API for the Genius.com song lyrics database";
    homepage = "https://github.com/johnwmillr/LyricsGenius";
    license = licenses.mit;
    maintainers = with maintainers; [
      educorreia932
    ];
  };
}
