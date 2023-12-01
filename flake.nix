{
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11"; };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = fn:
        nixpkgs.lib.genAttrs [ "aarch64-darwin" "x86_64-linux" ]
        (system: fn nixpkgs.legacyPackages.${system});
    in {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell { buildInputs = with pkgs; [ zig zls ]; };
      });
    };
}
