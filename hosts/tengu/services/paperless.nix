{
  services.paperless = {
    enable = true;
    port = 28981;
    consumptionDirIsPublic = true;
    dataDir = "/mnt/media/paperless";
    settings = {
      PAPERLESS_URL = "https://paperless.educorreia932.dev";
    };
  };
}
