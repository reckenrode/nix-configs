{ config, lib, pkgs, flakePkgs, unstablePkgs, x86_64, ... }:

let
  inherit (pkgs.vscode-utils) buildVscodeMarketplaceExtension;

  debugserver = "${flakePkgs.debugserver}/bin/debugserver";

  # Work around the lack of extension ordering in VS Code
  # See: https://github.com/Microsoft/vscode/issues/57481#issuecomment-910883638
  loadAfter = deps: pkg: pkg.overrideAttrs (old: {
    nativeBuildInputs = old.nativeBuildInputs or [ ] ++ [ pkgs.jq pkgs.moreutils ];

    preInstall = ''
      ${old.preInstall or ""}
      jq '.extensionDependencies |= . + $deps' \
      --argjson deps ${lib.escapeShellArg (builtins.toJSON deps)} \
      package.json | sponge package.json
    '';
  });

  bmalehorn.vscode-fish = buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "bmalehorn";
      name = "vscode-fish";
      version = "1.0.24";
      sha256 = "sha256-q0TzKQFSqRX7KUAjOJPkUPk00YbdyCK8S8DfD3vsKcI=";
    };
  };

  cab404.direnv = buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "cab404";
      name = "vscode-direnv";
      version = "1.0.0";
      sha256 = "sha256-+nLH+T9v6TQCqKZw6HPN/ZevQ65FVm2SAo2V9RecM3Y=";
    };
  };

  ionide.ionide-fsharp =
    let
      ionide.ionide-fsharp = buildVscodeMarketplaceExtension {
        mktplcRef = {
          publisher = "ionide";
          name = "ionide-fsharp";
          version = "5.10.2";
          sha256 = "sha256-bYbbJMhEcmOXxcUSY6qVJtXx2IjgAzLg3ie1SHsuHDE=";
        };
      };
    in
    loadAfter [ "cab404.vscode-direnv" ] ionide.ionide-fsharp;

  mark-hansen.hledger-vscode =
    let
      hledger-vscode = buildVscodeMarketplaceExtension {
        mktplcRef = {
          publisher = "mark-hansen";
          name = "hledger-vscode";
          version = "0.0.7";
          sha256 = "sha256-whQaXrzDhVbDRlT7uCK5ORkxT4f1X4cWwSS1YOvL5xI=";
        };
      };
    in
    loadAfter [ "cab404.vscode-direnv" ] hledger-vscode;

  matklad.rust-analyzer =
    let
      inherit (pkgs.vscode-extensions) matklad;
    in
    loadAfter [ "cab404.vscode-direnv" ] matklad.rust-analyzer;

  ombratteng.nftables = buildVscodeMarketplaceExtension {
    mktplcRef = {
      publisher = "ombratteng";
      name = "nftables";
      version = "0.4.4";
      sha256 = "sha256-zmTbF676rKhSR9qS+Iw23qvnsTLZFEswoS9e8sy+ec0=";
    };
  };
in
{
  programs.vscode = {
    enable = true;
    extensions =
      let
        inherit (pkgs.vscode-extensions) bbenoist editorconfig vadimcn;
      in
      [
        bbenoist.nix
        bmalehorn.vscode-fish
        cab404.direnv
        editorconfig.editorconfig
        ionide.ionide-fsharp
        mark-hansen.hledger-vscode
        matklad.rust-analyzer
        ombratteng.nftables
        vadimcn.vscode-lldb
      ];
    userSettings = {
      "editor.bracketPairColorization.enabled" = true;
      "editor.fontFamily" = "SF Mono, Menlo, Monaco, 'Courier New', monospace";
      "editor.guides.bracketPairs" = "active";
      "editor.minimap.enabled" = false;
      "editor.roundedSelection" = false;
      "editor.rulers" = [ 100 ];
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "explorer.sortOrder" = "mixed";
      "extensions.autoCheckUpdates" = false;
      "extensions.autoUpdate" = false;
      "git.path" = "${pkgs.git}/bin/git";
      "telemetry.enableTelemetry" = false;
      "telemetry.telemetryLevel" = "off";
      "update.mode" = "none";
      "window.titleBarStyle" = "native";
      "workbench.editor.tabCloseButton" = "left";
      "workbench.colorTheme" = "Default Light+";
      "lldb.adapterEnv" = {
        "LLDB_DEBUGSERVER_PATH" = debugserver;
      };
    };
  };
}
