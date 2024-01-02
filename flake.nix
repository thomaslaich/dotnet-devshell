{
  description = "A dev shell for basic dotnet development";

  inputs.devshell.url = "github:numtide/devshell";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = { self, flake-utils, devshell, nixpkgs, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          overlays = [ devshell.overlays.default ];
        };

        dotnet = pkgs.dotnet-sdk_7;

        devShell = pkgs.devshell.mkShell {
          name = "dotnet-devshell";
          commands = [{ package = dotnet; }];

          packages = [ ];
        };

      in { devShells.default = devShell; });
}
