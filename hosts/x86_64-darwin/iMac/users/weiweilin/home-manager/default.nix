{ pkgs
, ...
}:

{
  imports = [
    ./git.nix
  ];

  home.packages = [ pkgs.poetry pkgs.python3Full ];

  programs.vscode.enable = true;
}
