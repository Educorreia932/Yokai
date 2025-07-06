let
  tengu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOHTnwUvFUh+ht5jeiuI/+lRj5McWuN0Sx7YnF9piG4L eduardo@nixos";
in
{
  "transmission-password.age".publicKeys = [ tengu ];
  "sonata-bot-env.age".publicKeys = [ tengu ];
}
