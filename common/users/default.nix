{ lib, pkgs, ... }:

{
  users.users.reckenrode = {
    isNormalUser = true;
    description = "reckenrode";
    shell = pkgs.fish;
  } // lib.optionalAttrs pkgs.stdenv.isLinux {
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM+aydjZ/Yb8onZQ5OLyXZr18NchFZQcZh8yNEuK/wOM"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDTegWuvc3zHmVOMqcY8TJrLzWwS3W3ro4v7/782WoUHge2SuvLCinb8yyD+SgIg2OyEz8q+iXwNUaFOa7sTM20="
    ];
  };
}
