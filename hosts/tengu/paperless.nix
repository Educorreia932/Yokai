{
  environment.etc."paperless-admin-pass".text = "admin";
  services.paperless = {
    enable = true;
    passwordFile = "/etc/paperless-admin-pass";
    consumptionDirIsPublic = true;
    address = "http://188.245.156.123/paperless/";
  };
}
