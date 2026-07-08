let
  tengu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOHTnwUvFUh+ht5jeiuI/+lRj5McWuN0Sx7YnF9piG4L eduardo@nixos";
  bakeneko = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDUTbKJFQma6ieAD2hckAS38qV0U7rag2UVzFzEj8KPK5sjWOO2pEIsA5rrdVA0hzvTevRHeILiPwOAi6oQqdc6WIt8QW7Civf+2bwU5Ezl3ggQvoIvXMnWw0iNvUw5DRsIbSyQrxov0oNN+T+53HsjPgKYRLd5GUKikZaaWqUeKBrI2FeCF2vSE96oLa8oifqxbihhusE/gOi1Db3atuyfpUhCmaFlN3TygjZ9gWtYPDNPo5HW7q8AlvlTAOxOavJlsWdkuqSIzNVIxQygA2ym52K3Y1X/r3P/xP9U72c0wvEkTDp0pbA+Iuzdd7Vxt5dF8G3DuiZ4b58i3Vf2BVcFZRWHKtY6stK2Qy3vnCRfZp8ny6fGMCOu/8ufDsjer39wOQ2INXrwK0CB+CjO5glfw99Gq+8CMvLTYhARbKwPImOc710avMGs7JjY+1IwHj+Aq9ZtayWAX3hMAQbRf1hGUtL8VqTlIvnqnNXJv8YohfVUR2IMORxGOb+sl3sNG9byuvpUYMhpMVx0uRXN+yVKxRRNHTuY9NBe0mPR8e7gskgacoWYFhBdjiTPyoPgJ9S8IP1QC+ZlQ/YN0N4214WPY8rGNAt124GikkgUKODUMFqRNJuLDAn2huw6e79jsH1qGPq/Ov5x4MMEVJobM2ZZCgMC1nr9pvar4sSOP3I6gQ== skelo@Eduardo";
in
{
  "hetzner-cloud-api-key.age".publicKeys = [
    tengu
    bakeneko
  ];
  "homepage-dashboard-env.age".publicKeys = [
    tengu
    bakeneko
  ];
  "transmission-password.age".publicKeys = [
    tengu
    bakeneko
  ];
  "sonata-bot-env.age".publicKeys = [
    tengu
    bakeneko
  ];
  "szurubooru-secret.age".publicKeys = [
    tengu
    bakeneko
  ];
}
