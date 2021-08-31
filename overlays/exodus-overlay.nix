final: prev: {
  exodus = prev.exodus.overrideAttrs (oldAttrs: {
    version = "v21.8.27";
    src = prev.fetchurl {
      # url = "https://downloads.exodus.io/releases/exodus-linux-x64-20.8.28.zip";
      url = "https://downloads.exodus.io/releases/exodus-linux-x64-21.8.27.zip";
      sha256 = "0xdv2wxiy5ryx9ssq1vry7fw3vbslmwc9my2nd6j7i66qrnyksln";
      # sha256 = "1vv53l2f8kcjix62ngrqb84yh06j4vnf7p1di7v43mphf5gidsgx";
    };
    buildInputs = [ final.xorg.libxshmfence ];
  });
}
