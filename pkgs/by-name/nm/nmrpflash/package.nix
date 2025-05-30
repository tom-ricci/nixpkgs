{
  fetchFromGitHub,
  lib,
  libnl,
  libpcap,
  pkg-config,
  stdenv,
}:
stdenv.mkDerivation rec {
  pname = "nmrpflash";
  version = "0.9.25";

  src = fetchFromGitHub {
    owner = "jclehner";
    repo = "nmrpflash";
    rev = "v${version}";
    hash = "sha256-5oj+sIrVNAbLmmKHiBSDSVdJFrobK41UfWBmU0WRG3c=";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    libnl
    libpcap
  ];

  PREFIX = "${placeholder "out"}";
  STANDALONE_VERSION = version;

  preInstall = ''
    mkdir -p $out/bin
  '';

  meta = with lib; {
    description = "Netgear Unbrick Utility";
    homepage = "https://github.com/jclehner/nmrpflash";
    license = licenses.gpl3;
    maintainers = with maintainers; [ dadada ];
    mainProgram = "nmrpflash";
    platforms = platforms.unix;
  };
}
