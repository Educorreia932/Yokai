{
  services.paperless = {
    enable = true;
    address = "0.0.0.0";
    port = 28981;
    passwordFile = "/etc/paperless-admin-pass";
    consumptionDirIsPublic = true;
    dataDir = "/mnt/media/paperless"; 
  };
  environment.etc."paperless-admin-pass".text = "admin";
  systemd.services.paperless-scheduler.after = ["var-lib-paperless.mount"];
  systemd.services.paperless-consumer.after = ["var-lib-paperless.mount"];
  systemd.services.paperless-web.after = ["var-lib-paperless.mount"];
}
