let
  sharkeyUrl = "https://raw.githubusercontent.com/sodiboo/system/e99b0ada3c0101d1e271e59e370b310daa6bb404/sharkey/";
in
{
  imports = [
    (builtins.fetchurl {
      url = "${sharkeyUrl}/module.nix";
      sha256 = "sha256:0s0zr5kfbxql9jfzysggi367k2h4bkc0wf2d8sxx1ca7l72979ks";
    })
  ];

  nix = {
    settings = {
      substituters = [
        "cache.sodi.boo"
      ];
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      sharkey = final.callPackage (builtins.fetchurl {
        url = "${sharkeyUrl}/package.nix";
        sha256 = "sha256:0b01xznzrjv7mzrfklwaaa943mhv2yx4c8nlm023lzg735r1qdfb";
      }) { };
    })
  ];

  services.sharkey = {
    enable = true;
    domain = "tomobiki.city";
    database.passwordFile = ./sharkey-database-password;
    redis.passwordFile = ./sharkey-redis-password;
    settings = {
      id = "aidx";
      port = 3001;
      maxNoteLength = 8192;
      maxFileSize = 1024 * 1024 * 1024;
      proxyRemoteFiles = true;
      signToActivityPubGet = true;
      CheckActivityPubGetSigned = false;
    };
  };

  services.meilisearch = {
    masterKeyEnvironmentFile = ./sharkey-meili-master-key;
  };
}
