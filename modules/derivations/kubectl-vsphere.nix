{ pkgs }:
let
  pluginUrl = "https://10.127.215.1/wcp/plugin/darwin-amd64/vsphere-plugin.zip";
in
pkgs.stdenv.mkDerivation {
  name = "vsphere-plugin";

  buildInputs = [
    pkgs.unzip
    pkgs.coreutils
  ];

  src = builtins.fetchurl {
    url = pluginUrl;
    sha256 = "04id8r66spqi8c2ia09pm8n816dd78lhz24fa4bb2p82g7vbz5xd";
  };

  unpackPhase = ''
    mkdir -p $TMPDIR/vsphere-plugin
    ${pkgs.unzip}/bin/unzip $src -d $TMPDIR/vsphere-plugin
  '';

  installPhase = ''
    mkdir -p $out/bin
      if [ -d "$TMPDIR/vsphere-plugin" ]; then
        cp -r $TMPDIR/vsphere-plugin/bin/kubectl-vsphere $out/bin/
        chmod +x $out/bin/*
      else
        echo "Extraction failed: No files found in $TMPDIR/vsphere-plugin"
        exit 1
      fi  
  '';
}
