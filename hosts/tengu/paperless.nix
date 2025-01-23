{
  services.paperless = {
    enable = true;
    port = 28981;
    passwordFile = "/etc/paperless-admin-pass";
    consumptionDirIsPublic = true;
    dataDir = "/mnt/media/paperless"; 
  };
  environment.etc."paperless-admin-pass".text = "admin";
}
