{
  fetchPypi,
  buildPythonPackage,
  fetchurl,
}:
buildPythonPackage rec {
  pname = "pandare";
  version = "1.8.24";

  format = "wheel";
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-LbGkZPiQ42Kdkw6iDq9aAXAE8c8F7KUY3RAuLFkF+bw=";
    format = "wheel";
    dist = "py3";
    python = "py3";
  };




#   pyproject = true;
}
