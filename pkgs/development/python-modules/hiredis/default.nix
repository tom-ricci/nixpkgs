{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,

  # build-system
  setuptools,

  # tests
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "hiredis";
  version = "3.1.1";
  pyproject = true;

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "redis";
    repo = "hiredis-py";
    tag = "v${version}";
    fetchSubmodules = true;
    hash = "sha256-z28fBGqZE88vQuJfb39AEN3hGEZMz5gq71IdlpO5VAg=";
  };

  build-system = [ setuptools ];

  pythonImportsCheck = [ "hiredis" ];

  nativeCheckInputs = [ pytestCheckHook ];

  preCheck = ''
    rm -rf hiredis
  '';

  meta = with lib; {
    description = "Wraps protocol parsing code in hiredis, speeds up parsing of multi bulk replies";
    homepage = "https://github.com/redis/hiredis-py";
    changelog = "https://github.com/redis/hiredis-py/blob/${src.tag}/CHANGELOG.md";
    license = licenses.bsd3;
    maintainers = with maintainers; [ mmai ];
  };
}
