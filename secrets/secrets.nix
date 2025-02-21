let
  tengu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM59w3VsqgA+BBBYHEpJI+CTzvfDG6HohEayIuaY/CXS eduardo@nixos";
in
{
  "transmission-password.age".publicKeys = [
    tengu
  ];
}
